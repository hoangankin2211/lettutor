import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/utils/widgets/custom_appbar.dart';
import 'package:lettutor/core/utils/widgets/custom_stack_scroll.dart';
import 'package:lettutor/core/utils/widgets/infinity_scroll_view.dart';
import 'package:lettutor/domain/models/course/course_detail.dart';
import 'package:lettutor/ui/course/blocs/ebook_bloc.dart';
import 'package:lettutor/ui/course/blocs/ebook_state.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/widgets/app_loading_indicator.dart';
import '../../../core/core.dart';
import '../blocs/course_bloc.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with AutomaticKeepAliveClientMixin {
  late final PageController _pageController =
      PageController(initialPage: currentPage.value, keepPage: true);
  final ValueNotifier<int> currentPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      if (_pageController.page != null) {
        currentPage.value = _pageController.page!.ceil();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.theme.scaffoldBackgroundColor,
        title: Row(
          children: [
            SvgPicture.asset("assets/images/course_icon.svg", height: 50),
            const SizedBox(width: 10),
            Text(
              context.l10n.courses,
              style: context.textTheme.headlineMedium?.boldTextTheme
                  .copyWith(color: context.textTheme.bodyLarge?.color),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: context.theme.cardColor,
              borderRadius: BorderRadius.circular(25),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ValueListenableBuilder<int>(
              valueListenable: currentPage,
              builder: (context, value, child) => NavigationBar(
                selectedIndex: value,
                onDestinationSelected: (value) {
                  setState(() {
                    currentPage.value = value;
                    _pageController.animateToPage(
                      value,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceIn,
                    );
                  });
                },
                elevation: 0,
                backgroundColor: context.theme.cardColor,
                height: 55,
                destinations: [
                  NavigationDestination(
                      icon: const Icon(Icons.laptop),
                      label: context.l10n.courses),
                  const NavigationDestination(
                      icon: Icon(Icons.book), label: "E-Book")
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PageView(
                allowImplicitScrolling: true,
                controller: _pageController,
                children: const [
                  ListCoursePage(),
                  ListEBookPage(),
                ],
              ),
            ),
          ),
        ]
            .expand<Widget>((element) => [
                  element,
                  const SizedBox(height: 5),
                ])
            .toList(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ListCoursePage extends StatefulWidget {
  const ListCoursePage({super.key});

  @override
  State<ListCoursePage> createState() => _ListCoursePageState();
}

class _ListCoursePageState extends State<ListCoursePage>
    with AutomaticKeepAliveClientMixin {
  late final courseBloc = BlocProvider.of<CourseBloc>(context);
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<CourseBloc, CourseState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case InitialCourseListPage:
            return const AppLoadingIndicator();
          default:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: CourseSearchBar(
                    controller: searchController,
                    onSearch: (text) {
                      courseBloc.searchCourse(
                        q: text.isEmpty ? null : text,
                        isFilter: true,
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: state is LoadingListCourse
                      ? const Center(child: AppLoadingIndicator())
                      : RefreshIndicator(
                          onRefresh: courseBloc.fetchCourseList,
                          child: (state is ErrorCourseList)
                              ? CustomTemplateScreenStackScroll(
                                  appBar: AppBarCustom(
                                    expandedHeight: context.height * 0.3,
                                    backgroundColor: Colors.transparent,
                                  ),
                                  children: [
                                    SliverToBoxAdapter(
                                      child: Center(
                                        child: Text(state.message),
                                      ),
                                    )
                                  ],
                                )
                              : (state.data.course.isEmpty)
                                  ? CustomTemplateScreenStackScroll(
                                      appBar: AppBarCustom(
                                        expandedHeight: context.height * 0,
                                        backgroundColor: Colors.transparent,
                                      ),
                                      children: [
                                        SliverToBoxAdapter(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.person_search_outlined,
                                                color: context.theme.hintColor
                                                    .withOpacity(0.5),
                                                size: 100,
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    "Can not find any course !",
                                                    style: context
                                                        .textTheme
                                                        .headlineSmall
                                                        ?.boldTextTheme,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : DefaultPagination<CourseDetail>(
                                      page: state.data.page,
                                      totalPage: state.data.totalPage,
                                      separatorBuilder: (p0, p1) {
                                        return const SizedBox(height: 20);
                                      },
                                      listenScrollBottom: () =>
                                          courseBloc.loadMoreCourse(
                                              page: state.data.page + 1),
                                      physics: const BouncingScrollPhysics(),
                                      items: state.data.course,
                                      loading: state is LoadingListCourse,
                                      itemBuilder: (context, index) {
                                        final courseItem =
                                            state.data.course.elementAt(index);
                                        return CourseWidget(
                                          key: ValueKey(
                                              "${courseItem.id}_CourseScreen"),
                                          onTap: (id) {
                                            context.push(
                                              RouteLocation.courseDetail,
                                              extra: {
                                                "courseId": id,
                                                "from": "CourseScreen"
                                              },
                                            );
                                          },
                                          courseId: courseItem.id,
                                          imageUrl: courseItem.imageUrl,
                                          title: courseItem.name,
                                          subTitle: courseItem.description,
                                          level: courseItem.level,
                                        );
                                      },
                                    ),
                        ),
                ),
              ],
            );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class ListEBookPage extends StatefulWidget {
  const ListEBookPage({super.key});

  @override
  State<ListEBookPage> createState() => _ListEBookPageState();
}

class _ListEBookPageState extends State<ListEBookPage>
    with AutomaticKeepAliveClientMixin {
  late final eBookBloc = BlocProvider.of<EBookBloc>(context);

  @override
  void didChangeDependencies() {
    // eBookBloc.fetchEBookList(page: 1, perPage: 12);
    super.didChangeDependencies();
  }

  void _launcherURl(String? ebookUrl) async {
    if (ebookUrl?.isNotEmpty ?? false) {
      final Uri url = Uri.parse(ebookUrl!);
      if (!await launchUrl(url)) {
        // ignore: use_build_context_synchronously
        throw Exception("${context.l10n.couldNotLaunchUrl} $url");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EBookBloc, EBookState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case LoadingListEBook || InitialEBookListPage:
            return const Center(child: CircularProgressIndicator());
          case ErrorEBookList:
            return const Center(child: Text("Error"));

          default:
            return Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child:
                        CourseSearchBar(controller: TextEditingController())),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    shrinkWrap: true,
                    itemCount: 10,
                    addAutomaticKeepAlives: true,
                    itemBuilder: (context, index) {
                      final ebookItem = state.data.eBook.elementAt(index);
                      return CourseWidget(
                        marginTop: index == 0 ? 15 : 0,
                        key: ValueKey("${ebookItem.id}_CourseScreen"),
                        onTap: (id) {
                          _launcherURl(ebookItem.fileUrl);
                        },
                        courseId: ebookItem.id,
                        imageUrl: ebookItem.imageUrl,
                        title: ebookItem.name,
                        subTitle: ebookItem.description,
                        level: ebookItem.level,
                      );
                    },
                  ),
                ),
              ],
            );
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
