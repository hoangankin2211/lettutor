import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lettutor/core/components/extensions/extensions.dart';
import 'package:lettutor/core/components/navigation/routes_location.dart';
import 'package:lettutor/core/components/widgets/infinity_scroll_view.dart';
import 'package:lettutor/domain/models/tutor/tutor.dart';
import 'package:lettutor/ui/course/views/widgets/course_search_bar.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_bloc.dart';
import 'package:lettutor/ui/tutor/views/widgets/tutor_widget.dart';

import '../../../core/logger/custom_logger.dart';

class TutorScreen extends StatefulWidget {
  const TutorScreen({super.key});

  @override
  State<TutorScreen> createState() => _TutorScreenState();
}

class _TutorScreenState extends State<TutorScreen>
    with AutomaticKeepAliveClientMixin {
  late final tutorBloc = BlocProvider.of<TutorBloc>(context);

  @override
  void initState() {
    tutorBloc.loadTutor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<TutorBloc, TutorState>(
      bloc: tutorBloc,
      builder: (context, tutorState) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: context.theme.scaffoldBackgroundColor,
            title: GestureDetector(
              onTap: () {
                tutorBloc.loadTutor();
              },
              child: Text(
                'Tutor',
                style: context.textTheme.titleLarge?.boldTextTheme,
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              children: [
                CourseSearchBar(controller: TextEditingController()),
                Expanded(
                  child: DefaultPagination<Tutor>(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final tutor = tutorState.data.tutors[index];
                      return TutorWidget(
                        onTap: () {
                          context.push(
                            RouteLocation.tutorDetail,
                            extra: {"tutorId": tutor.userId},
                          );
                        },
                        imageUrl: tutor.avatar,
                        name: tutor.name,
                        country: tutor.country,
                        specialties:
                            tutor.specialties.split(RegExp(r'[-\n ,]')),
                        rating: tutor.rating,
                        description: tutor.bio,
                        price: tutor.price,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    items: tutorState.data.tutors,
                    listenScrollBottom: () {
                      logger.d(
                          "${tutorState.data.page}---${tutorState.data.count}");
                      if (tutorState.data.page + 1 >
                          (tutorState.data.count.toDouble() /
                                  tutorState.data.perPage)
                              .ceil()) {
                        return;
                      }
                      tutorBloc.loadTutor(page: tutorState.data.page + 1);
                    },
                    loading: tutorState is TutorLoading,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
