import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/elevated_border_button.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/domain/models/user.dart';
import 'package:lettutor/generated/l10n.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';

class BecomeTutorView extends StatefulWidget {
  const BecomeTutorView({super.key});

  @override
  State<BecomeTutorView> createState() => _BecomeTutorViewState();
}

class _BecomeTutorViewState extends State<BecomeTutorView> {
  AuthBloc get authBloc => BlocProvider.of<AuthBloc>(context);

  User? get _currentUser => authBloc.state.user;

  Color get _primaryColor => context.theme.primaryColor;

  TextStyle? get _hintColorText =>
      context.textTheme.titleSmall?.copyWith(color: context.theme.hintColor);

  TextStyle? get _smallText =>
      context.textTheme.titleSmall?.copyWith(fontSize: 12.0);

  DateTime selectedDate = DateTime.now();

  Object? listen;

  final _interestsController = TextEditingController();

  final _eductionController = TextEditingController();

  final _experienceController = TextEditingController();

  final _professionController = TextEditingController();

  final _bioController = TextEditingController();

  final _languageController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _onSelectedTime() async {
    await context.showAppDatePicker().then((value) {
      setState(() {
        selectedDate = value ?? selectedDate;
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _body(context),
        if (false)
          Container(
              color: Colors.black45,
              width: context.width,
              height: context.height,
              child: AppLoadingIndicator())
      ],
    );
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedBorderButton(
          onPressed: () {
            // _bloc.registeringTutor({
            //   'interest': _interestsController.text,
            //   'education': _eductionController.text,
            //   'experience': _experienceController.text,
            //   'profession': _professionController.text,
            //   'bio': _bioController.text,
            //   'language': _languageController.text,
            // });
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
      body: Stepper(
        currentStep: 0,
        onStepContinue: () {
          // if (currentIndex < 3) {
          //   _bloc.changeStep(currentIndex + 1);
          // }
        },
        onStepCancel: () {},
        onStepTapped: (index) {
          // _bloc.changeStep(index);
        },
        steps: <Step>[
          Step(
            title: Text("Introduction", style: context.textTheme.titleMedium),
            content: _renderIntroduction(),
          ),
          Step(
            title: Text('CV', style: context.textTheme.titleMedium),
            content: _renderCV(),
          ),
          Step(
            title: Text("Language", style: context.textTheme.titleMedium),
            content: _languageRender(),
          ),
          Step(
            title: Text("Who I Tech", style: context.textTheme.titleMedium),
            content: _renderTypeStudent(),
          )
        ],
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
        const SizedBox(height: 10.0),
        SizedBox(
          width: double.infinity,
          child: DropdownButton<String?>(
            // items: Constant.userLevels.entries
            //     .mapIndexed(
            //       (index, element) => DropdownMenuItem(
            //         value: element.key,
            //         child: Text(element.value),
            //       ),
            //     )
            //     .toList(),
            items: [],
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

  Widget _topicsField(
      {required List<LearnTopics> topics,
      required List<LearnTopics> topicsSelected}) {
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
        // _informationTextField(
        //   controller: _interestsController,
        //   labelText: S.of(context).interests,
        //   hintText: S.of(context).EnterYourInterests,
        // ),
        // const SizedBox(),
        // _informationTextField(
        //   controller: _eductionController,
        //   labelText: S.of(context).education,
        //   hintText: S.of(context).enterEducation,
        // ),
        // const SizedBox(),
        // _informationTextField(
        //   controller: _experienceController,
        //   labelText: S.of(context).experiences,
        //   hintText: S.of(context).EnterYourExperiences,
        //   lines: 1,
        // ),
        // const SizedBox(),
        // _informationTextField(
        //   controller: _professionController,
        //   labelText: S.of(context).professions,
        //   hintText: S.of(context).EnterYourProfessions,
        //   lines: 2,
        // ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Column _renderIntroduction() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "your Tutor Profile",
          style: _hintColorText,
        ),
        _dividerText(text: "basicInfo"),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {},
              child: _renderSelectedAvatar(),
            ),
            const SizedBox(width: 15.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _countryCodeField(),
                  _dateBornField(),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10.0),
        _informationTextField(
          controller: _bioController,
          labelText: "Bio",
          hintText: "Enter your Bio",
        ),
      ].expand((e) => [e, const SizedBox(height: 10.0)]).toList(),
    );
  }

  Widget _dateBornField() {
    return Row(
      children: [
        Expanded(
            child: Text(
          "getYmdFormat(data)",
          style: context.textTheme.titleSmall,
        )),
        InkWell(
            // padding: const EdgeInsets.all(0.0),
            onTap: _onSelectedTime,
            child: Icon(Icons.calendar_month_rounded, color: _primaryColor))
      ],
    );
  }

  Row _countryCodeField() {
    return Row(
      children: [
        Text('I\' from ', style: context.textTheme.titleSmall),
        Expanded(
          child: CountryCodePicker(
            padding: const EdgeInsets.all(0),
            initialSelection: "VN",
            showCountryOnly: false,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            dialogBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
            showFlagMain: true,
            showFlag: true,
            hideSearch: false,
            showFlagDialog: true,
            onChanged: (value) {},
          ),
        )
      ],
    );
  }

  Widget _renderSelectedAvatar() => const Placeholder();
  // => StreamBuilder(
  //     stream: _bloc.bothImageData$,
  //     builder: (ctx, sS) {
  //       final data = sS.data;
  //       if (data?.image.isNotNull ?? false) {
  //         return ClipRRect(
  //           borderRadius: BorderRadius.circular(5.0),
  //           child: Image.memory(
  //             data!.image!,
  //             width: 100,
  //             height: 100,
  //             fit: BoxFit.cover,
  //           ),
  //         );
  //       }
  //       return Container(
  //         width: 100,
  //         height: 100,
  //         decoration: BoxDecoration(
  //           border: Border.all(width: 1, color: _primaryColor),
  //           borderRadius: BorderRadius.circular(5.0),
  //           color: Theme.of(context).cardColor,
  //         ),
  //         alignment: Alignment.center,
  //         child: Text(
  //           S.of(context).tapToSelectedAvatar,
  //           style: context.titleSmall.copyWith(fontSize: 11.0),
  //           textAlign: TextAlign.center,
  //         ),
  //       );
  //     });

  TextFormField _informationTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
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
