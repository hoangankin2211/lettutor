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

import '../../auth/blocs/auth_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final authBloc = BlocProvider.of<AuthBloc>(context);
  late final appBloc = BlocProvider.of<ApplicationBloc>(context);

  String get userEmail => authBloc.state.user?.email ?? "";
  String get userName => authBloc.state.user?.name ?? "";
  String get location => authBloc.state.user?.country ?? "";
  String? get avatar => authBloc.state.user?.avatar;
  IconData get themeIcon => context.theme.brightness == Brightness.light
      ? Icons.dark_mode
      : Icons.light_mode;

  int selectedLanguage = 0;

  List<String> get language => [
        context.l10n.english,
        context.l10n.vietnamese,
      ];

  String languageSelection() => language.elementAt(selectedLanguage);

  int selectedTheme = 0;

  List<String> get theme => [
        context.l10n.system,
        context.l10n.light,
        context.l10n.dark,
      ];

  String themeSelection() => theme.elementAt(selectedTheme);

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
        },
        {
          'title': 'displaySettingChoice',
          'icon': CupertinoIcons.globe,
          'onTap': () => showCupertinoChoiceBottomSheet(
                initialItem: selectedLanguage,
                data: language,
                onSelectedItemChanged: (value) {
                  logger.d(value);
                  setState(() => selectedLanguage = value);
                },
              ),
          'selection': languageSelection,
          'content': context.l10n.languages,
        },
        {
          'title': 'displaySettingChoice',
          'icon': themeIcon,
          'onTap': () => showCupertinoChoiceBottomSheet(
              data: theme,
              onSelectedItemChanged: (value) =>
                  setState(() => selectedTheme = value),
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
                        backgroundColor: context.colorScheme.onPrimary,
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
        color: Colors.transparent,
        paddingAll: const EdgeInsets.all(5),
        afterMainScreen: Image.asset("assets/images/home_v2.png"),
        appBar: AppBarCustom(
          expandedHeight: context.height * 0.32,
          backgroundColor: Colors.transparent,
          paddingLeft: 20,
          title: const [],
        ),
        children: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              decoration: BoxDecoration(
                color: context.colorScheme.onPrimary,
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
                                      ? context.theme.hintColor
                                          .withOpacity(0.05)
                                      : null,
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
                                          cacheHeight: 60,
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
                          BlocProvider.of<AuthBloc>(context)
                              .add(LogoutAuthenticationRequest());
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                            horizontal: 20,
                          ),
                          decoration: BoxDecoration(
                            color: context.theme.hintColor.withOpacity(0.05),
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
                                child: BlocBuilder<AuthBloc, AuthState>(
                                  bloc: authBloc,
                                  builder: (context, state) {
                                    return state.isLoading
                                        ? const AppLoadingIndicator(radius: 15)
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
