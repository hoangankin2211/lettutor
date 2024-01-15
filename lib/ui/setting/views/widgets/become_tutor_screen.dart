import 'dart:io';

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:language_code/language_code.dart';
import 'package:lettutor/core/constants/enum.dart';
import 'package:lettutor/core/dependency_injection/di.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/data/entities/request/become_tutor_request.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/tutor/views/widgets/booking_dialog.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_video_player.dart';

class BecomeTutorScreen extends StatefulWidget {
  const BecomeTutorScreen({super.key});

  @override
  State<BecomeTutorScreen> createState() => _BecomeTutorScreenState();
}

class _BecomeTutorScreenState extends State<BecomeTutorScreen> {
  final GlobalKey<_EnterIntroductionVideoViewState> _videoIntroductionKey =
      GlobalKey<_EnterIntroductionVideoViewState>();
  final GlobalKey<_EnterProfileViewState> _profileKey =
      GlobalKey<_EnterProfileViewState>();

  int currentPage = 0;

  late PageController pageController =
      PageController(initialPage: currentPage, keepPage: true);

  bool isLoading = false;

  TutorUseCase tutorUseCase = injector.get<TutorUseCase>();

  bool showFloatingButton = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: !showFloatingButton
          ? null
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: context.theme.primaryColor, width: 1.5),
                      ),
                      onPressed: () {
                        if (pageController.page == 2) {
                          return;
                        }
                        pageController.previousPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        );
                      },
                      label: Text(
                        "Previous",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.theme.primaryColor,
                        ),
                      ),
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                      elevation: 0,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    child: FloatingActionButton.extended(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                            color: context.theme.primaryColor, width: 1.5),
                      ),
                      onPressed: () async {
                        if (pageController.page == 0 &&
                            !_profileKey.currentState!._isValidate()) {
                          return;
                        }
                        if (pageController.page == 1 &&
                            _videoIntroductionKey.currentState!.video == null) {
                          context.showSnackBarAlert(
                              "context.l10n.pleaseUploadYourIntroductionVideo");
                          return;
                        }

                        if (pageController.page == 1) {
                          try {
                            setState(() {
                              isLoading = true;
                            });
                            final result =
                                await tutorUseCase.registerBecomeTutor(
                              BecomeTeacherRequest(
                                avatar: _profileKey.currentState!._avatar!.path,
                                bio: _profileKey.currentState!._name.text,
                                country:
                                    _profileKey.currentState!.country.code ??
                                        "VN",
                                birthday:
                                    _profileKey.currentState!.selectedDateTime,
                                education: _profileKey
                                    .currentState!._eductionController.text,
                                experience: _profileKey
                                    .currentState!._experienceController.text,
                                interests: _profileKey
                                    .currentState!._interestsController.text,
                                languages:
                                    _profileKey.currentState!.language.toList(),
                                profession: _profileKey
                                    .currentState!._professionController.text,
                                targetStudent:
                                    _profileKey.currentState!._studentType,
                                specialties: _profileKey
                                    .currentState!.selectedTag
                                    .map((e) => e.name)
                                    .toList(),
                                videoIntroduction: _videoIntroductionKey
                                    .currentState!.video!.path,
                                name: _profileKey.currentState!._name.text,
                                price: 5000,
                              ),
                            );

                            setState(() {
                              isLoading = false;
                            });

                            result.either(
                                (left) => context.showSnackBarAlert(
                                    "context.l10n.registerSuccessfully: $left"),
                                (right) {
                              context.showSnackBarAlert(right);
                              throw Exception(right);
                            });
                          } catch (e) {
                            print(e);
                            return;
                          }
                        }

                        pageController
                            .nextPage(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeIn,
                        )
                            .then((value) {
                          currentPage = pageController.page!.toInt();
                        });
                      },
                      label: isLoading
                          ? AppLoadingIndicator(
                              radius: 10, color: context.colorScheme.primary)
                          : Text(
                              "Continue",
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: context.theme.primaryColor,
                              ),
                            ),
                      backgroundColor: context.theme.scaffoldBackgroundColor,
                      elevation: 0,
                    ),
                  ),
                ],
              ),
            ),
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: context.textTheme.titleLarge?.color),
          onPressed: context.pop,
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          context.l10n.tutorRegister,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: PageView(
        controller: pageController,
        allowImplicitScrolling: false,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          EnterProfileView(key: _profileKey),
          EnterIntroductionVideoView(key: _videoIntroductionKey),
          ApprovalView(onGotoHome: context.pop),
        ],
      ),
    );
  }
}

class EnterIntroductionVideoView extends StatefulWidget {
  const EnterIntroductionVideoView({super.key});

  @override
  State<EnterIntroductionVideoView> createState() =>
      _EnterIntroductionVideoViewState();
}

class _EnterIntroductionVideoViewState extends State<EnterIntroductionVideoView>
    with AutomaticKeepAliveClientMixin {
  XFile? video;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            _renderIntroduction(),
            _renderVideo(),
            const SizedBox(height: 70),
          ].expand((element) => [element, const SizedBox(height: 20)]).toList(),
        ),
      ),
    );
  }

  Row _dividerText({required String text}) {
    return Row(
      children: const [Divider(), Divider()]
          .asMap()
          .entries
          .expand((element) => [
                Expanded(child: element.value),
                if (element.key == 0)
                  Text(
                    text,
                    style: context.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
              ])
          .toList(),
    );
  }

  Widget _renderHighLightNotice(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: context.theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Widget _renderIntroduction() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              "assets/images/tutor-video.svg",
              height: 150,
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Introduce yourself",
                    style: context.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Let students know what they can expect from a lesson with you by recording a video highlighting your teaching style, expertise and personality. Students can be nervous to speak with a foreigner, so it really helps to have a friendly video that introduces yourself and invites students to call you.",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: context.theme.hintColor),
                  ),
                ],
              ),
            )
          ],
        ),
        _dividerText(text: "Introduction Video"),
        _renderHighLightNotice(
          Text.rich(
            TextSpan(
              text: """A few helpful tips:
 1. Find a clean and quiet space
 2. Smile and look at the camera
 3. Dress smart
 4. Speak for 1-3 minutes
 5. Brand yourself and have fun!\n""",
              children: [
                TextSpan(
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: Colors.red),
                    text:
                        "Note: We only support uploading video file that is less than 64 MB in size.")
              ],
            ),
          ),
        )
      ].expand((element) => [element, const SizedBox(height: 10)]).toList(),
    );
  }

  Widget _renderVideo() {
    return video != null
        ? LetTutorVideoPlayer(
            url: video!.path,
            width: context.height * 0.1,
            height: context.width,
          )
        : InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              final ImagePicker picker = ImagePicker();
              final _video =
                  await picker.pickVideo(source: ImageSource.gallery);

              if (_video != null) {
                setState(() {
                  video = _video;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/upload.png",
                    height: 150,
                    width: 150,
                  ),
                  Text(
                    "Update Your Video",
                    style: context.textTheme.bodyLarge,
                  )
                ],
              ),
            ),
          );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class ApprovalView extends StatelessWidget {
  const ApprovalView({super.key, required this.onGotoHome});
  final Function() onGotoHome;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Icon(
          Icons.tag_faces_outlined,
          size: 200,
          color: context.theme.primaryColor,
        ),
        Text(
          "You have dont all the steps",
          style: context.textTheme.titleLarge,
        ),
        Text(
          "Please, wait for the operator's approval",
          style: context.textTheme.titleLarge,
        ),
        ElevatedButton(
          onPressed: onGotoHome,
          child: Text("Go to Home",
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.onPrimary,
              )),
        ),
        const Spacer(),
        const Spacer(),
      ],
    );
  }
}

class EnterProfileView extends StatefulWidget {
  const EnterProfileView({super.key});

  @override
  State<EnterProfileView> createState() => _EnterProfileViewState();
}

class _EnterProfileViewState extends State<EnterProfileView>
    with AutomaticKeepAliveClientMixin {
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  Color get _primaryColor => context.theme.primaryColor;

  TextStyle? get _hintColorText =>
      context.textTheme.titleSmall?.copyWith(color: context.theme.hintColor);

  TextStyle? get _smallText =>
      context.textTheme.titleSmall?.copyWith(fontSize: 12.0);
  final Set<String> studentType = {"Beginner", "Intermediate", "Advanced"};

  bool isLoading = false;

  CountryCode country = CountryCode(code: "VN");
  final _interestsController = TextEditingController();
  final _eductionController = TextEditingController();
  final _experienceController = TextEditingController();
  final _professionController = TextEditingController();
  final _name = TextEditingController();
  final _languageController = TextEditingController();
  String _studentType = "Beginner";
  DateTime selectedDateTime = DateTime.now();
  final Set<String> language = {};
  final Set<TutorTag> selectedTag = {TutorTag.All};
  File? _avatar;

  @override
  void initState() {
    super.initState();
  }

  bool _isValidate() {
    if (_avatar == null) {
      context.showSnackBarAlert("context.l10n.pleaseUploadYourAvatar");
      return false;
    }
    if (_name.text.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseEnterYourTutoringName");
      return false;
    }
    if (_interestsController.text.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseEnterYourInterests");
      return false;
    }
    if (_eductionController.text.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseEnterYourEducation");
      return false;
    }
    if (_experienceController.text.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseEnterYourExperiences");
      return false;
    }
    if (_professionController.text.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseEnterYourProfessions");
      return false;
    }
    if (language.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseSelectYourLanguage");
      return false;
    }
    if (selectedTag.isEmpty) {
      context.showSnackBarAlert("context.l10n.pleaseSelectYourSpecialties");
      return false;
    }
    return true;
  }

  void _onSelectedTime() async {
    await context.showAppDatePicker().then((value) {
      setState(() {
        selectedDateTime = value ?? selectedDateTime;
      });
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _interestsController.dispose();
    _eductionController.dispose();
    _experienceController.dispose();
    _professionController.dispose();
    _languageController.dispose();
    super.dispose();
  }

  bool isInitState = true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoading
        ? const Center(child: AppLoadingIndicator(radius: 30))
        : SingleChildScrollView(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                _renderIntroduction(),
                _renderCV(),
                _renderCertificate(),
                _languageRender(),
                _renderTypeStudent(),
                const SizedBox(height: 70),
              ],
            ),
          );
  }

  Column _renderTypeStudent() {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _dividerText(text: "Who I teach"),
          _renderHighLightNotice(
            Text(
              "This is the first thing students will see when looking for tutors.",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text("I am best at teaching students who are", style: _hintColorText),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: context.theme.dividerColor, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButton<String>(
              icon: const Icon(Icons.keyboard_arrow_down),
              iconSize: 24,
              underline: const SizedBox(),
              value: _studentType,
              items: studentType
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (String? value) {
                setState(() {
                  _studentType = value!;
                });
              },
            ),
          ),
          Text(
            "My Specialties Are",
            style: context.textTheme.titleSmall?.copyWith(
              color: context.theme.hintColor,
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            spacing: 4,
            children: [
              for (final tag in TutorTag.values)
                if (tag.name.isNotEmpty)
                  ChoiceChip(
                    selectedColor: context.theme.primaryColor.withOpacity(0.1),
                    label: Text(tag.name),
                    selected: selectedTag.contains(tag),
                    onSelected: (value) {
                      setState(() {
                        if (!value) {
                          selectedTag.remove(tag);
                        } else {
                          selectedTag.add(tag);
                        }
                      });
                    },
                  ),
            ],
          ),
        ].expand((e) => [const SizedBox(height: 10.0), e]).toList());
  }

  Column _languageRender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: "Language"),
        InkWell(
          onTap: () {
            showLanguagePicker();
          },
          child: Container(
            constraints: BoxConstraints(minHeight: 35),
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: context.width,
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: context.theme.dividerColor, width: 1.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: language.isEmpty
                ? Text("Select Your Language")
                : Wrap(
                    direction: Axis.horizontal,
                    spacing: 4,
                    runSpacing: 4,
                    children: [
                      for (final language in language)
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: context.theme.primaryColor,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            language,
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                    ],
                  ),
          ),
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _renderHighLightNotice(Widget child) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(
        color: context.theme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  Column _renderCV() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: 'CV'),
        Text(
          "Students will view this information on your profile to decide if you're a good fit for them.",
          style: _hintColorText,
        ),
        _renderHighLightNotice(
          Text(
              "In order to protect your privacy, please do not share your personal information (email, phone number, social email, skype, etc) in your profile.",
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.theme.primaryColor,
                fontWeight: FontWeight.w500,
              )),
        ),
        const SizedBox(),
        _informationTextField(
          controller: _interestsController,
          labelText: context.l10n.interests,
          hintText:
              "Interests, hobbies, memorable life experiences, or anything else you'd like to share!",
        ),
        const SizedBox(),
        _informationTextField(
          controller: _eductionController,
          labelText: context.l10n.education,
          hintText:
              "Example: 'Bachelor of Arts in English from Cambly University; Certified yoga instructor, Second Language Acquisition and Teaching  (SLAT) certificate from Cambly University'",
        ),
        const SizedBox(),
        _informationTextField(
          controller: _experienceController,
          labelText: context.l10n.experiences,
          hintText: context.l10n.enterYourExperiences,
          lines: 1,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _professionController,
          labelText: "Current or Previous Profession",
          hintText: context.l10n.EnterYourProfessions,
          lines: 2,
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _renderCertificate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        _dividerText(text: "Certificate"),
        SizedBox(
          height: 35,
          child: ElevatedBorderButton(
            child: Text(
              "Add New Certificate",
              style: context.textTheme.bodyMedium
                  ?.copyWith(color: context.theme.primaryColor),
            ),
            onPressed: () {},
          ),
        ),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Expanded(
                flex: 5,
                child: BookingDialogField(
                  title: Text("Certificate Type"),
                  body: Text("TOEFL"),
                ),
              ),
              const Expanded(
                  flex: 4,
                  child: BookingDialogField(
                    title: Text("Certificate"),
                    body: Text("seminar_bloc.pptx"),
                  )),
              Expanded(
                flex: 3,
                child: BookingDialogField(
                  title: Text("Action"),
                  body: InkWell(
                    onTap: () {},
                    child: Icon(Icons.delete,
                        color: context.colorScheme.error, size: 20),
                  ),
                ),
              ),
            ],
          ),
        )
      ].expand((element) => [element, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _renderIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.l10n.yourTutorProfile,
          style: _hintColorText,
        ),
        _dividerText(text: context.l10n.basicInfo),
        Center(
          child: GestureDetector(
            onTap: () async {
              XFile? _image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (_image != null) {
                setState(() {
                  _avatar = File(_image.path);
                });
              }
            },
            child: _renderSelectedAvatar(),
          ),
        ),
        _informationTextField(
          controller: _name,
          labelText: "Tutoring Name",
          hintText: "Tutoring Name",
          lines: 1,
        ),
        InkWell(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            height: 35,
            decoration: BoxDecoration(
              border: Border.fromBorderSide(
                BorderSide(color: context.theme.dividerColor, width: 1.5),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: CountryCodePicker(
              flagDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              initialSelection: "VN",
              showCountryOnly: true,
              backgroundColor: context.theme.scaffoldBackgroundColor,
              dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
              showFlagMain: true,
              showFlag: true,
              hideSearch: false,
              showFlagDialog: true,
              builder: (p0) {
                return Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Image.asset(
                        p0!.flagUri!,
                        package: 'country_code_picker',
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      country.name ?? "Select your Country",
                      style: context.textTheme.bodyLarge,
                    )
                  ],
                );
              },
              onChanged: (value) {
                setState(() {
                  country = value;
                });
              },
            ),
          ),
        ),
        InkWell(
          onTap: _onSelectedTime,
          child: _informationTextField(
            isEnable: false,
            lines: 1,
            controller: TextEditingController(
                text: DateFormat().add_yMMMEd().format(selectedDateTime)),
            labelText: "Date of Birth",
            hintText: "Enter your DOB",
          ),
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _renderSelectedAvatar() => CircleAvatar(
        radius: context.width * 0.3,
        backgroundColor: Colors.white30,
        foregroundImage: _avatar == null
            ? const AssetImage("assets/images/user.png")
            : FileImage(_avatar!) as ImageProvider,
      );

  void showLanguagePicker() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Select Language"),
          content: Container(
            width: context.width * 0.8,
            height: context.height * 0.5,
            child: ListView.builder(
              itemCount: LanguageCodes.values.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(LanguageCodes.values[index].name),
                  onTap: () {
                    setState(() {
                      if (language.contains(LanguageCodes.values[index].name)) {
                        language.remove(LanguageCodes.values[index].name);
                      } else {
                        language.add(LanguageCodes.values[index].name);
                      }
                    });
                    context.pop();
                  },
                  trailing: language.contains(LanguageCodes.values[index].name)
                      ? const Icon(Icons.check)
                      : null,
                );
              },
            ),
          ),
        );
      },
    );
  }

  TextFormField _informationTextField({
    bool isEnable = true,
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    int lines = 3,
  }) {
    LanguageCode.setTestCode(LanguageCodes.fromCode("vi"));
    return TextFormField(
      enabled: isEnable,
      controller: controller,
      maxLines: lines,
      style: _smallText,
      decoration: InputDecoration(
        labelStyle: TextStyle(decorationColor: _primaryColor),
        labelText: labelText,
        hintText: hintText,
        hintStyle: _smallText?.copyWith(
          color: Theme.of(context).hintColor,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 10,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
          gapPadding: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: _primaryColor, width: 1.5),
          gapPadding: 10,
        ),
      ),
    );
  }

  Row _dividerText({required String text}) {
    return Row(
      children: const [Divider(), Divider()]
          .asMap()
          .entries
          .expand((element) => [
                Expanded(child: element.value),
                if (element.key == 0)
                  Text(
                    text,
                    style: context.textTheme.titleSmall
                        ?.copyWith(fontWeight: FontWeight.bold),
                  )
              ])
          .toList(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
