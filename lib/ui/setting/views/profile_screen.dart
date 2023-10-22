import 'package:auto_size_text/auto_size_text.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/data/entities/user_entity.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/setting/views/widgets/custom_drop_down_btn.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studySchedule = TextEditingController();
  late ValueNotifier<String?> _countryCode = ValueNotifier(countryCode);
  late ValueNotifier<String> _birthday = ValueNotifier(birthday);
  late ValueNotifier<String> _level = ValueNotifier(level);

  late final authBloc = BlocProvider.of<AuthBloc>(context);

  String get userEmail => authBloc.state.user?.email ?? "";
  String get userName => authBloc.state.user?.name ?? "";
  String get birthday => authBloc.state.user?.birthday ?? "";
  String get location => authBloc.state.user?.country ?? "";
  String? get avatar => authBloc.state.user?.avatar;
  String get countryCode => authBloc.state.user?.country ?? "";
  String get phone => authBloc.state.user?.phone ?? "";
  String get amount => authBloc.state.user?.walletInfo.amount ?? "";
  String get level => authBloc.state.user?.level ?? "";
  List<LearnTopics> get topic => authBloc.state.user?.learnTopics ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: context.colorScheme.primary,
            elevation: 0,
            minimumSize: Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          onPressed: () {},
          child: Text(
            "Update",
            style: context.textTheme.titleMedium?.boldTextTheme
                .copyWith(color: context.colorScheme.onPrimary),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "Profile Information",
          style: context.textTheme.titleLarge?.boldTextTheme,
        ),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios,
              color: context.textTheme.titleLarge?.color),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _informationTextField({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    IconData? iconData,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (iconData != null)
              Icon(
                iconData,
                color: context.theme.hintColor,
                size: 25,
              ),
            const SizedBox(width: 5),
            Text(
              labelText,
              style: context.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            labelStyle: TextStyle(decorationColor: context.colorScheme.primary),
            // labelText: labelText,
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 20,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1.5),
              gapPadding: 10,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide:
                  BorderSide(color: context.colorScheme.primary, width: 1.5),
              gapPadding: 10,
            ),
          ),
        ),
      ],
    );
  }

  Row _avatarField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundImage: avatar != null ? NetworkImage(avatar!) : null,
            radius: 80,
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  [Icons.email, userEmail],
                  [Icons.phone, phone],
                  [Icons.wallet, amount]
                ]
                    .map<Widget>(
                      (e) => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            e[0] as IconData,
                            color: context.theme.hintColor,
                            size: 35,
                          ),
                          const SizedBox(width: 10),
                          AutoSizeText(
                            e[1] as String,
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            style: context.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList()),
          ),
        ),
      ],
    );
  }

  // Widget informationField(){

  // }

  Container _selectedCountryField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1.5, color: Theme.of(context).dividerColor),
      ),
      child: ValueListenableBuilder(
          valueListenable: _countryCode,
          builder: (_, countryCode, __) {
            return Row(
              children: [
                CountryCodePicker(
                  padding: const EdgeInsets.all(0),
                  initialSelection: countryCode,
                  showCountryOnly: false,
                  showOnlyCountryWhenClosed: false,
                  enabled: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  dialogBackgroundColor:
                      Theme.of(context).scaffoldBackgroundColor,
                  hideMainText: false,
                  showFlagMain: true,
                  showFlag: true,
                  hideSearch: false,
                  showFlagDialog: true,
                  onChanged: (value) {
                    _countryCode.value = value.code;
                  },
                ),
                Expanded(
                    child: Text(countryCode ?? "",
                        style: context.textTheme.titleMedium))
              ],
            );
          }),
    );
  }

  static Map<String, String> userLevels = {
    "BEGINNER": "Pre A1 (Beginner)",
    "HIGHER_BEGINNER": "A1 (Higher Beginner)",
    "PRE_INTERMEDIATE": "A2 (Pre-Intermediate)",
    "INTERMEDIATE": "B1 (Intermediate)",
    "UPPER_INTERMEDIATE": "B2 (Upper-Intermediate)",
    "ADVANCED": "C1 (Advanced)",
    "PROFICIENCY": "C2 (Proficiency)",
  };

  ValueListenableBuilder<String> _levelField() {
    return ValueListenableBuilder<String>(
      valueListenable: _level,
      builder: (_, level, __) {
        return SizedBox(
          width: double.infinity,
          child: CustomDropDownButton<String?>(
            borderWidth: 1.5,
            radius: 10.0,
            items: userLevels.entries
                .map(
                  (element) => DropdownMenuItem(
                    value: element.key,
                    child: Text(element.value),
                  ),
                )
                .toList(),
            value: level.toUpperCase(),
            onChange: (value) {
              if (value?.isNotEmpty ?? false) {
                _level.value = value!;
              }
            },
          ),
        );
      },
    );
  }

  Widget _topicsField({
    required List<LearnTopics> topics,
    required List<LearnTopics> topicsSelected,
  }) {
    return Wrap(
      spacing: 6.0,
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
                color: isSelected ? context.colorScheme.primary : null,
                fontWeight: FontWeight.w400,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            avatar: isSelected
                ? Icon(Icons.check,
                    color: context.colorScheme.primary, size: 15.0)
                : null,
            selected: isSelected,
            onSelected: (_) {},
            backgroundColor: Theme.of(context).dividerColor.withOpacity(0.07),
            selectedColor: context.colorScheme.primary.withOpacity(0.1),
          );
        })
      ],
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _avatarField(),
            _informationTextField(
              iconData: CupertinoIcons.person_fill,
              controller: TextEditingController(),
              labelText: "Name",
              hintText: "Name",
            ),
            ...["Birthday", "Country", "Levels", "Topics And Preparations"]
                .asMap()
                .entries
                .map<Widget>(
                  (e) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.value,
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w400,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      switch (e.key) {
                        0 => _calendarField(),
                        1 => _selectedCountryField(),
                        2 => _levelField(),
                        _ => _topicsField(
                            topics: topic,
                            topicsSelected: [],
                          ),
                      }
                    ],
                  ),
                )
          ]
              .expand<Widget>(
                  (element) => [element, const SizedBox(height: 20)])
              .toList(),
        ));
  }

  ValueListenableBuilder<dynamic> _calendarField() {
    return ValueListenableBuilder(
      valueListenable: _birthday,
      builder: (_, birthDay, __) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border:
                Border.all(width: 1.5, color: Theme.of(context).dividerColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                    DateFormat().add_yMMMd().format(DateTime.parse(birthday)),
                    style: context.textTheme.titleMedium),
              ),
              InkWell(
                onTap: () => showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                  confirmText: "Select",
                  cancelText: "Cancel",
                ),
                child: Icon(Icons.calendar_month,
                    color: context.theme.primaryColor),
              )
            ],
          ),
        );
      },
    );
  }
}
