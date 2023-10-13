// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lettutor/data/entities/ebook_entity.dart';

class EBookDataState {
  final List<EBookEntity> eBook;
  final int page;
  final int count;
  const EBookDataState({
    this.eBook = const [],
    this.page = 1,
    this.count = 0,
  });

  EBookDataState copyWith({
    List<EBookEntity>? eBook,
    int? page,
    int? count,
  }) {
    return EBookDataState(
      eBook: eBook ?? this.eBook,
      page: page ?? this.page,
      count: count ?? this.count,
    );
  }
}

abstract class EBookState {
  final EBookDataState data;
  const EBookState({required this.data});
}

class InitialEBookListPage extends EBookState {
  const InitialEBookListPage() : super(data: const EBookDataState());
}

class LoadingListEBook extends EBookState {
  const LoadingListEBook({required super.data});
}

class LoadListEBookSuccess extends EBookState {
  const LoadListEBookSuccess({required super.data});
}

class ErrorEBookList extends EBookState {
  final String message;
  const ErrorEBookList({required this.message, required super.data});
}
