import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/ui/course/blocs/course_bloc.dart';
import 'package:lettutor/ui/course/blocs/ebook_bloc.dart';
import 'package:lettutor/ui/dashboard/blocs/dashboard_state.dart';
import 'package:lettutor/ui/schedule/bloc/schedule_bloc.dart';
import 'package:lettutor/ui/tutor/blocs/tutor_bloc.dart';

@injectable
class DashboardBloc extends Cubit<DashboardState> {
  final CourseBloc courseBloc;
  final EBookBloc eBookBloc;
  final TutorBloc tutorBloc;
  final ScheduleBloc scheduleBloc;

  DashboardBloc(
    this.courseBloc,
    this.eBookBloc,
    this.tutorBloc,
    this.scheduleBloc,
  ) : super(DashboardInitial());

  void changeTab(int index) {
    emit(DashboardTabChanged(data: state.data.copyWith(currentPage: index)));
  }

  void fetchInitialApplicationData() {
    emit(DashboardLoading(data: state.data));
    Future.wait([
      courseBloc.fetchCourseList(),
      eBookBloc.fetchEBookList(),
      tutorBloc.searchTutor(),
      tutorBloc.fetchUpcomingClass(),
      scheduleBloc.fetchScheduleList(),
    ]).then(
      (value) => emit(DashboardLoaded(data: state.data)),
    );
  }
}
