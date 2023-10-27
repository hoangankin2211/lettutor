import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lettutor/core/components/widgets/elevated_border_button.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/domain/models/course/course_detail.dart';
import 'package:lettutor/ui/course/blocs/ebook_bloc.dart';
import 'package:lettutor/ui/course/blocs/ebook_state.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/course/views/widgets/course_widget.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/components/widgets/app_loading_indicator.dart';
import '../../../core/components/widgets/custom_navigator_bar.dart';
import '../../../core/core.dart';
import '../blocs/course_bloc.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with AutomaticKeepAliveClientMixin {
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
              'Course',
              style: context.textTheme.headlineMedium?.boldTextTheme
                  .copyWith(color: context.textTheme.bodyLarge?.color),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CustomNavigatorBar(
              tabs: [
                "Course",
                "E-Book",
                "Interactive",
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: PageView(
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
                  const SizedBox(height: 20),
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
  void initState() {
    // courseBloc.fetchCourseList();

    super.initState();
  }

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
        if (state is InitialCourseListPage) {
          return const AppLoadingIndicator();
        } else if (state is ErrorCourseList) {
          return Center(child: Text(state.message));
        } else {
          return Column(
            children: [
              CourseSearchBar(
                controller: searchController,
                onTapFilter: () {},
                onSearch: (text) {
                  courseBloc.searchCourse(
                    q: text.isEmpty ? null : text,
                    isFilter: true,
                  );
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: state is LoadingListCourse
                    ? const Center(child: AppLoadingIndicator())
                    : RefreshIndicator(
                        onRefresh: courseBloc.fetchCourseList,
                        child: DefaultPagination<CourseDetail>(
                          page: state.data.page,
                          totalPage: state.data.totalPage,
                          separatorBuilder: (p0, p1) {
                            return const SizedBox(height: 20);
                          },
                          listenScrollBottom: () => courseBloc.loadMoreCourse(
                              page: state.data.page + 1),
                          physics: const BouncingScrollPhysics(),
                          items: state.data.course,
                          loading: state is LoadingListCourse,
                          itemBuilder: (context, index) {
                            final courseItem =
                                state.data.course.elementAt(index);
                            return CourseWidget(
                              key: ValueKey("${courseItem.id}_CourseScreen"),
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
        throw Exception("Could not launch url $url");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<EBookBloc, EBookState>(
      builder: (context, state) {
        if (state is LoadingListEBook || state is InitialEBookListPage) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is LoadListEBookSuccess) {
          return Column(
            children: [
              CourseSearchBar(controller: TextEditingController()),
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
        } else {
          return const Center(child: Text("Error"));
        }
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

enum National {
  vietnam,
  england,
}

enum TutorTag {
  All("All"),
  Englishforkids("English for kids"),
  EnglishforBusiness('English for Business'),
  Conversational("Conversational"),
  STARTERS("STARTERS"),
  MOVERS("MOVERS"),
  FLYERS("FLYERS"),
  KET("KET"),
  PET("PET"),
  IELTS("IELTS"),
  TOEFL("TOEFL"),
  TOEIC("TOEIC");

  final String name;
  const TutorTag(this.name);
}

class FilterSheet extends StatefulWidget {
  const FilterSheet({super.key, this.onDone});

  final void Function(Map<String, dynamic> result)? onDone;

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  DateTime? selectedDate;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  TutorTag selectedTag = TutorTag.All;
  National? national = National.vietnam;

  void openCalendar() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      confirmText: "Select",
      cancelText: "Cancel",
    ).then((value) {
      setState(() {
        selectedDate = value ?? selectedDate;
      });
    });
  }

  Future<TimeOfDay?> openDateRange(TimeOfDay? startTime) {
    return showTimePicker(
      context: context,
      initialTime: startTime ?? TimeOfDay.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your tutor's national",
              style: context.textTheme.titleMedium?.boldTextTheme,
            ),
            DropdownMenu<National>(
              initialSelection: national,
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide:
                      BorderSide(color: context.theme.hintColor, width: 0.5),
                ),
              ),
              onSelected: (value) {
                if (value != null) {
                  setState(() {
                    national = value;
                  });
                }
              },
              dropdownMenuEntries: const [
                DropdownMenuEntry(
                  value: National.vietnam,
                  label: "Vietnamese Tutor",
                ),
                DropdownMenuEntry(
                  value: National.england,
                  label: "Native English Tutor",
                ),
              ],
              label: Text(
                "National",
                style: context.textTheme.bodyLarge,
              ),
              leadingIcon: Icon(Icons.location_pin),
            ),
            Text(
              "Select Available tutoring time",
              style: context.textTheme.titleMedium?.boldTextTheme,
            ),
            ElevatedButton.icon(
              onPressed: openCalendar,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: context.theme.hintColor, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 0,
              ),
              icon: Icon(
                Icons.calendar_month,
                color: context.theme.hintColor,
              ),
              label: Text(
                selectedDate == null
                    ? "Select Date"
                    : DateFormat().add_yMd().format(selectedDate!),
                style: context.textTheme.bodyLarge,
              ),
            ),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    openDateRange(startTime).then((value) {
                      setState(() {
                        startTime = value ?? startTime;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: context.theme.hintColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: context.theme.hintColor,
                  ),
                  label: Text(
                    startTime == null
                        ? "Select Start Time"
                        : "${startTime!.hour}:${startTime!.minute}",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    openDateRange(startTime).then((value) {
                      if (value == null) return;
                      setState(() {
                        endTime = value;
                      });
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: context.theme.hintColor, width: 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 0,
                  ),
                  icon: Icon(
                    Icons.calendar_month,
                    color: context.theme.hintColor,
                  ),
                  label: Text(
                    endTime == null
                        ? "Select End Time"
                        : "${endTime!.hour}:${endTime!.minute}",
                    style: context.textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Text(
              "Select Tutor Tags",
              style: context.textTheme.titleMedium?.boldTextTheme,
            ),
            Wrap(
              direction: Axis.horizontal,
              spacing: 5,
              runSpacing: 4,
              children: [
                for (final tag in TutorTag.values)
                  ChoiceChip(
                    selectedColor: context.theme.primaryColor.withOpacity(0.1),
                    label: Text(tag.name),
                    selected: tag == selectedTag,
                    onSelected: (value) {
                      if (value) {
                        setState(() {
                          selectedTag = tag;
                        });
                      }
                    },
                  ),
              ],
            ),
            Center(
              child: SizedBox(
                width: context.width * 0.5,
                child: ElevatedBorderButton(
                  onPressed: () {
                    if (widget.onDone != null) {
                      widget.onDone!({
                        "national": national,
                        "startTime": startTime,
                        "endTime": endTime,
                        "selectedDate": selectedDate,
                        "selectedTag": selectedTag,
                      });
                    }
                  },
                  backgroundColor: context.theme.dialogBackgroundColor,
                  borderColor: context.theme.primaryColor,
                  child: Text(
                    "Ok",
                    style: context.textTheme.bodyLarge
                        ?.copyWith(color: context.theme.primaryColor),
                  ),
                ),
              ),
            ),
          ]
              .expand<Widget>((element) => [
                    element,
                    if (element is! Text) const SizedBox(height: 20),
                  ])
              .toList(),
        ),
      ),
    );
  }
}
