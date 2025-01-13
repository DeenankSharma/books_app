import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/data/models/book_model.dart';
import 'package:untitled1/data/services/books_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchBooksEvent>(fetchBooksEvent);
  }

  Future<void> fetchBooksEvent(
      FetchBooksEvent event, Emitter<HomeState> emit) async {
    emit(HomeFetchedBooksLoadingState());
    try {
      final books = await fetchBooks();
      emit(HomeFetchedBooksState(books: books));
    } catch (er) {
      emit(HomeBooksFetchedErrorState());
    }
  }
}
