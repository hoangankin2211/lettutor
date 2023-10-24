import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:lettutor/domain/usecases/course_usecase.dart';
import 'package:lettutor/ui/course/blocs/ebook_state.dart';

@injectable
class EBookBloc extends Cubit<EBookState> {
  final CourseUseCase courseUseCase;
  EBookBloc(this.courseUseCase) : super(const InitialEBookListPage());

  Future<void> fetchEBookList({
    int perPage = 10,
    int page = 1,
  }) async {
    emit(LoadingListEBook(data: state.data));

    courseUseCase.getEBookList(page: page, size: 10).then((value) {
      if (!isClosed) {
        value.fold(
          (l) => emit(ErrorEBookList(message: l, data: state.data)),
          (r) => emit(LoadListEBookSuccess(
            data: state.data.copyWith(
              eBook: r.eBoos,
              page: page,
              count: r.count,
            ),
          )),
        );
      }
    });
  }
}
