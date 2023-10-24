// ignore_for_file: public_member_api_docs, sort_constructors_first
class DashboardDataState {
  final int currentPage;

  DashboardDataState({this.currentPage = 0});

  DashboardDataState copyWith({
    int? currentPage,
  }) {
    return DashboardDataState(
      currentPage: currentPage ?? this.currentPage,
    );
  }
}

abstract class DashboardState {
  final DashboardDataState data;
  DashboardState({required this.data});
}

class DashboardInitial extends DashboardState {
  DashboardInitial() : super(data: DashboardDataState());
}

class DashboardLoading extends DashboardState {
  DashboardLoading({required DashboardDataState data}) : super(data: data);
}

class DashboardLoaded extends DashboardState {
  DashboardLoaded({required DashboardDataState data}) : super(data: data);
}

class DashboardError extends DashboardState {
  final String message;
  DashboardError({required DashboardDataState data, required this.message})
      : super(data: data);
}

class DashboardTabChanged extends DashboardState {
  DashboardTabChanged({required DashboardDataState data}) : super(data: data);
}
