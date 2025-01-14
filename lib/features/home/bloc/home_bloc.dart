import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/data/models/book_model.dart';
import 'package:untitled1/data/services/books_api.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<FetchBooksEvent>(fetchBooksEvent);
    on<LoadMoreBooksEvent>(loadMoreBooks);
  }

  int loads = 0;
  List<BookModel> currentBooks = [];

  Future<void> fetchBooksEvent(
      FetchBooksEvent event, Emitter<HomeState> emit) async {
    emit(HomeFetchedBooksLoadingState(books: [], isLoadingMore: false));
    try {
      loads = 1;
      currentBooks = await fetchBooks(loads.toString());
      emit(HomeFetchedBooksState(books: currentBooks, isLoadingMore: false));
    } catch (er) {
      emit(HomeBooksFetchedErrorState());
    }
  }

  Future<void> loadMoreBooks(
      LoadMoreBooksEvent event, Emitter<HomeState> emit) async {
    if (state is HomeFetchedBooksState) {
      emit(HomeFetchedBooksState(books: currentBooks, isLoadingMore: true));
      try {
        loads = loads + 1;
        final newBooks = await fetchBooks(loads.toString());
        currentBooks.addAll(newBooks);
        emit(HomeFetchedBooksState(books: currentBooks, isLoadingMore: false));
      } catch (er) {
        emit(LoadMoreBooksErrorState(error: er.toString()));
        emit(HomeFetchedBooksState(books: currentBooks, isLoadingMore: false));
      }
    }
  }
}
