import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/widgets/custom_appbar.dart';
import 'package:lettutor/core/components/widgets/custom_stack_scroll.dart';

import '../../auth/blocs/auth_bloc.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final authBloc = BlocProvider.of<AuthBloc>(context);

  String get userEmail => authBloc.state.user?.email ?? "";
  String get userName => authBloc.state.user?.name ?? "";
  String get location => authBloc.state.user?.country ?? "";
  String? get avatar => authBloc.state.user?.avatar;
  IconData get themeIcon => context.theme.brightness == Brightness.light
      ? Icons.dark_mode
      : Icons.light_mode;

  late final List<Map<String, dynamic>> displayInformation = [
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
  late final List<Map<String, dynamic>> displaySettingChoice = [
    {
      'title': 'displaySettingChoice',
      'icon': CupertinoIcons.person_2_alt,
      'content': "Become a tutor",
    },
    {
      'title': 'displaySettingChoice',
      'icon': CupertinoIcons.globe,
      'content': "Language",
    },
    {
      'title': 'displaySettingChoice',
      'icon': themeIcon,
      'content': "Appearance",
    },
  ];

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
                          .map<Widget>((e) => Container(
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
                              ))
                          .toList()
                        ..insert(
                            2,
                            Text(
                              "Other Settings",
                              style: context.textTheme.titleLarge,
                            ))
                        ..insert(
                          0,
                          Container(
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
                        ))
                      .toList()
                      .expand<Widget>((element) => [
                            element,
                            const SizedBox(height: 10),
                          ])
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }
}
