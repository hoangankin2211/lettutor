// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'application_bloc.dart';

abstract class ApplicationState {
  final ApplicationDataState data;

  ApplicationState({
    required this.data,
  });
}

class ApplicationInitialState extends ApplicationState {
  ApplicationInitialState({
    required ApplicationDataState data,
  }) : super(data: data);
}
