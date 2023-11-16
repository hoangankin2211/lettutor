import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/usecases/tutor_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

class BecomeTutorView extends ConsumerStatefulWidget {
  const BecomeTutorView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _BecomeTutorViewState();
}

class _BecomeTutorViewState extends ConsumerState<BecomeTutorView> {
  AuthBloc get authBloc => BlocProvider.of<AuthBloc>(context);


  DateTime selectedDateTime = DateTime.now();

  Color get _primaryColor => context.theme.primaryColor;

  TextStyle? get _hintColorText =>
      context.textTheme.titleSmall?.copyWith(color: context.theme.hintColor);

  TextStyle? get _smallText =>
      context.textTheme.titleSmall?.copyWith(fontSize: 12.0);

  bool isLoading = false;

  CountryCode country = CountryCode(code: "VN");

  Object? listen;

  final _interestsController = TextEditingController();

  final _eductionController = TextEditingController();

  final _experienceController = TextEditingController();

  final _professionController = TextEditingController();

  final _bioController = TextEditingController();

  final _languageController = TextEditingController();

  RegisterBecomeTutorProvider get register => registerBecomeTutorProvider(
        interest: _interestsController.text,
        education: _eductionController.text,
        experience: _experienceController.text,
        profession: _professionController.text,
        bio: _bioController.text,
        language: _languageController.text,
      );

  @override
  void initState() {
    super.initState();
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
    _bioController.dispose();
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
    ref.listen(register, (previous, next) {
      if (isInitState) {
        isInitState = false;
        return;
      }
      final value = next.value!;
      context.showSnackBarAlert(value.isRight ? value.right : value.left);
    });
    final request = ref.watch(register);
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedBorderButton(
          onPressed: () {
            ref.refresh(register);
          },
          child: Text(
            context.l10n.registerAccount,
            style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold, color: context.theme.primaryColor),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          context.l10n.tutorRegister,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: request.isLoading
          ? const Center(child: AppLoadingIndicator(radius: 30))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  _renderIntroduction(),
                  _renderCV(),
                  _languageRender(),
                  _renderTypeStudent(),
                ],
              ),
            ),
    );
  }

  Column _renderTypeStudent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "I am best teaching at",
          style: context.textTheme.titleSmall?.copyWith(
            color: Theme.of(context).hintColor,
          ),
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          child: DropdownButton<String?>(
            items: const [],
            // value: data.toUpperCase(),
            onChanged: (String? value) {},
          ),
        ),
        const SizedBox(height: 20.0),
        Text(
          "My Specialties Are",
          style: context.textTheme.titleSmall?.copyWith(
            color: context.theme.hintColor,
          ),
        ),
        _topicsField(
          topics: [],
          topicsSelected: [],
        )
      ],
    );
  }

  Widget _topicsField({
    required List<LearnTopics> topics,
    required List<LearnTopics> topicsSelected,
  }) {
    return Wrap(
      spacing: 6.0,
      runSpacing: -8,
      alignment: WrapAlignment.start,
      verticalDirection: VerticalDirection.up,
      children: [
        ...topics.map((e) {
          final isSelected =
              topicsSelected.indexWhere((element) => element.key == e.key) !=
                  -1;
          return ChoiceChip(
            label: Text(
              e.name,
              style: context.textTheme.titleSmall?.copyWith(
                fontSize: 14,
                color: isSelected ? _primaryColor : null,
                fontWeight: FontWeight.w400,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            avatar: isSelected
                ? Icon(Icons.check, color: _primaryColor, size: 15.0)
                : null,
            selected: isSelected,
            onSelected: (_) {},
            backgroundColor: Theme.of(context).dividerColor.withOpacity(0.07),
            selectedColor: _primaryColor.withOpacity(0.1),
          );
        })
      ],
    );
  }

  Column _languageRender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: "Language"),
        _informationTextField(
          controller: _languageController,
          labelText: "Languages",
          hintText: "lang 1, lang 2, ....",
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _renderCV() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _dividerText(text: 'CV'),
        Text(
          "Students Will View This Information",
          style: _hintColorText,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _interestsController,
          labelText: context.l10n.interests,
          hintText: context.l10n.interests,
        ),
        const SizedBox(),
        _informationTextField(
          controller: _eductionController,
          labelText: context.l10n.education,
          hintText: context.l10n.enterEducation,
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
          labelText: context.l10n.professions,
          hintText: context.l10n.EnterYourProfessions,
          lines: 2,
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
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
            onTap: () {},
            child: _renderSelectedAvatar(),
          ),
        ),
        // _countryCodeField(),
        InkWell(
          onTap: () {},
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                  border: Border.fromBorderSide(
                    BorderSide(color: context.theme.dividerColor, width: 1.5),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: CountryCodePicker(
                  padding: const EdgeInsets.all(0),
                  initialSelection: "VN",
                  showCountryOnly: true,
                  backgroundColor: context.theme.scaffoldBackgroundColor,
                  dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
                  showFlagMain: true,
                  showFlag: true,
                  hideSearch: false,
                  showFlagDialog: true,
                  onChanged: (value) {
                    setState(() {
                      country = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: _informationTextField(
                  controller: TextEditingController(),
                  labelText: "Country",
                  hintText: "Select your Country",
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: _onSelectedTime,
          child: _informationTextField(
            controller: TextEditingController(
                text: DateFormat().add_yMMMEd().format(selectedDateTime)),
            labelText: "Date of Birth",
            hintText: "Enter your DOB",
          ),
        ),
        _informationTextField(
          controller: _bioController,
          labelText: "Bio",
          hintText: "Enter your Bio",
        ),
        _informationTextField(
          controller: _bioController,
          labelText: "Bio",
          hintText: "Enter your Bio",
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _renderSelectedAvatar() => CircleAvatar(
        radius: context.width * 0.3,
        backgroundColor: Colors.white30,
        foregroundImage: const AssetImage("assets/images/user.png"),
      );

  TextFormField _informationTextField({
    TextEditingController? controller,
    String? labelText,
    String? hintText,
    int lines = 3,
  }) {
    return TextFormField(
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
}
