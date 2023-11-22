import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/utils/blocs/app_bloc.dart/application_bloc.dart';
import 'package:lettutor/core/utils/extensions/extensions.dart';
import 'package:lettutor/core/utils/navigation/routes_location.dart';
import 'package:lettutor/core/utils/widgets/app_loading_indicator.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/generated/l10n.dart';

import '../../auth/blocs/auth_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AuthenticationBloc get authBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  ApplicationBloc get appBloc => BlocProvider.of<ApplicationBloc>(context);

  String get userEmail => authBloc.state.user?.email ?? "";

  String get userName => authBloc.state.user?.name ?? "";

  String get location => authBloc.state.user?.country ?? "";

  String? get avatar => authBloc.state.user?.avatar;

  IconData get themeIcon => context.theme.brightness == Brightness.light
      ? Icons.dark_mode
      : Icons.light_mode;

  int get selectedLanguage => language
      .indexWhere((element) => element.keys.first == languageSelection());

  List<Map<String, String>> get language => [
        {S.delegate.supportedLocales[0].languageCode: context.l10n.english},
        {S.delegate.supportedLocales[1].languageCode: context.l10n.vietnamese},
      ];

  String languageSelection() => language
      .firstWhere((element) => element.containsKey(appBloc.state.data.language))
      .values
      .first;

  List<Map<String, String>> get theme => [
        {"system": context.l10n.system},
        {"light": context.l10n.light},
        {"dark": context.l10n.dark},
      ];

  int get selectedTheme => theme.indexWhere(
      (element) => element.keys.first == appBloc.state.data.themeMode.name);

  String themeSelection() => theme.elementAt(selectedTheme).values.first;

  List<Map<String, dynamic>> get displayInformation => [
        {
          'title': 'displayInformation',
          'icon': CupertinoIcons.mail,
          'content': userEmail,
        },
        {
          'title': 'displayInformation',
          'icon': Icons.location_on_sharp,
          'content': Country.parse(location).name,
        },
      ];

  List<Map<String, dynamic>> get displaySettingChoice => [
        {
          'title': 'displaySettingChoice',
          'icon': Icons.history,
          'content': context.l10n.history,
          'onTap': openHistoryPage,
        },
        {
          'title': 'displaySettingChoice',
          'icon': CupertinoIcons.person_2_alt,
          'content': context.l10n.becomeTutor,
          'onTap': () => context.push(RouteLocation.becomeTutor),
        },
        {
          'title': 'displaySettingChoice',
          'icon': CupertinoIcons.globe,
          'onTap': () => showCupertinoChoiceBottomSheet(
                initialItem: selectedLanguage,
                data: language
                    .map((e) => e.values)
                    .expand<String>((element) => element)
                    .toList(),
                onSelectedItemChanged: (value) {
                  logger.d(value);
                  appBloc.add(
                    LanguageChangedEvent(
                        language: language.elementAt(value).keys.first),
                  );
                },
              ),
          'selection': languageSelection,
          'content': context.l10n.languages,
        },
        {
          'title': 'displaySettingChoice',
          'icon': themeIcon,
          'onTap': () => showCupertinoChoiceBottomSheet(
              data: theme
                  .map((e) => e.values)
                  .expand<String>((element) => element)
                  .toList(),
              onSelectedItemChanged: (value) =>
                  appBloc.add(ChangeThemeModeEvent(
                      themeMode: switch (theme.elementAt(value).keys.first) {
                    "light" => ThemeMode.light,
                    "dark" => ThemeMode.dark,
                    "system" => ThemeMode.system,
                    _ => ThemeMode.system,
                  })),
              initialItem: selectedTheme),
          'selection': themeSelection,
          'content': context.l10n.appearance,
        },
      ];

  void showCupertinoChoiceBottomSheet({
    required void Function(int) onSelectedItemChanged,
    required List<String> data,
    required int initialItem,
  }) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) {
          int tempIndex = initialItem;
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 50,
                      scrollController: FixedExtentScrollController(
                        initialItem: tempIndex,
                      ),
                      onSelectedItemChanged: (value) {
                        tempIndex = value;
                      },
                      children:
                          data.map((e) => Center(child: Text(e))).toList(),
                    ),
                  ),
                  SizedBox(
                    width: context.width * 0.5,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: context.theme.cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                            color: context.colorScheme.primary,
                            width: 1,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onSelectedItemChanged(tempIndex);
                        context.pop();
                      },
                      icon: Icon(
                        Icons.check,
                        color: context.colorScheme.primary,
                      ),
                      label: Text(
                        "Ok",
                        style: context.textTheme.titleMedium,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  void openUserProfile() {
    context.push("${RouteLocation.setting}/${RouteLocation.profile}");
  }

  void openHistoryPage() {
    context.push("${RouteLocation.setting}/${RouteLocation.history}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomTemplateScreenStackScroll(
        color: context.theme.scaffoldBackgroundColor,
        paddingAll: const EdgeInsets.all(5),
        afterMainScreen: Image.asset("assets/images/home_v2.png"),
        appBar: AppBarCustom(
          expandedHeight: context.height * 0.32,
          backgroundColor: Colors.transparent,
        ),
        children: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: context.theme.scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(25)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: ([...displayInformation, ...displaySettingChoice]
                        .map<Widget>((e) => GestureDetector(
                              onTap: e['onTap'],
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                  horizontal: 20,
                                ),
                                decoration: BoxDecoration(
                                  color: e['title'] == "displaySettingChoice"
                                      ? context.theme.cardColor
                                      : null,
                                  border: Border.all(width: 0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(flex: 1, child: Icon(e['icon'])),
                                    const SizedBox(width: 10),
                                    Expanded(
                                        flex: 6, child: Text(e['content'])),
                                    if (e["selection"] != null)
                                      Text(e["selection"]()),
                                    if (e['title'] == "displaySettingChoice")
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        onPressed: () {},
                                        icon: const Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          size: 15,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ))
                        .toList()
                      ..insert(
                          2,
                          Text(
                            context.l10n.otherSetting,
                            style: context.textTheme.titleLarge,
                          ))
                      ..insert(
                        0,
                        GestureDetector(
                          onTap: openUserProfile,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: avatar != null
                                      ? CircleAvatar(
                                          foregroundImage:
                                              NetworkImage(avatar!),
                                          backgroundImage: const AssetImage(
                                              "assets/images/user.png"),
                                        )
                                      : Image.asset(
                                          "assets/images/user.png",
                                          fit: BoxFit.contain,
                                          height: 60,
                                        ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 9),
                                    child: Text(
                                      userName,
                                      style: context.textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  constraints: const BoxConstraints(),
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      ..insert(
                        0,
                        Text(
                          context.l10n.profileSetting,
                          style: context.textTheme.titleLarge,
                        ),
                      )
                      ..add(GestureDetector(
                        onTap: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LogoutAuthenticationRequest());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.cardColor,
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Icon(
                                  Icons.logout,
                                  color: context.colorScheme.error,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                flex: 6,
                                child: BlocBuilder<AuthenticationBloc,
                                    AuthenticationState>(
                                  bloc: authBloc,
                                  builder: (context, state) {
                                    return state.isLoading
                                        ? AppLoadingIndicator(
                                            radius: 15,
                                            color: context.colorScheme.error,
                                          )
                                        : Text(
                                            context.l10n.logOut,
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                              color: context.colorScheme.error,
                                            ),
                                          );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      )))
                    .toList()
                    .expand<Widget>(
                      (element) => [
                        element,
                        const SizedBox(height: 10),
                      ],
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
