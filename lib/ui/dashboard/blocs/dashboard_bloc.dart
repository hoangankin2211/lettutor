import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/core/logger/custom_logger.dart';
import 'package:lettutor/core/utils/networking/socket/app_socket.dart';
import 'package:lettutor/domain/usecases/chat_usecase.dart';
import 'package:lettutor/ui/auth/blocs/auth_bloc.dart';
import 'package:lettutor/ui/chat/bloc/chat_list_cubit.dart';
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
  final AuthenticationBloc authenticationBloc;
  final ChatListCubit chatListCubit;
  final ChatUseCase chatUseCase;
  final AppSocket appSocket;

  DashboardBloc(
    this.courseBloc,
    this.appSocket,
    this.eBookBloc,
    this.tutorBloc,
    this.scheduleBloc,
    this.chatListCubit,
    this.authenticationBloc,
    this.chatUseCase,
  ) : super(DashboardInitial());

  void changeTab(int index) {
    emit(DashboardTabChanged(data: state.data.copyWith(currentPage: index)));
  }

  Future<void> fetchInitialApplicationData() async {
    emit(DashboardLoading(data: state.data));
    if (authenticationBloc.state.user != null) {
      logger.d("Init socket");
      appSocket.initSocket(authenticationBloc.state.user!);
      appSocket.connectSocket();
      chatUseCase.connectSocket();
      chatListCubit.connectSocket();
    }
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

  @override
  Future<void> close() {
    appSocket.disconnectSocket();
    return super.close();
  }
}
