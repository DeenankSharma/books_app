import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/data/services/search_api.dart';
import 'package:untitled1/features/search/bloc/search_event.dart';
import 'package:untitled1/features/search/bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchBooksEvent>(_onSearchBooks);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onSearchBooks(
    SearchBooksEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    try {
      final books = await searchBooks(event.query);
      emit(SearchSuccess(books));
    } catch (e) {
      emit(SearchErrorState('Failed to search books: ${e.toString()}'));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<SearchState> emit,
  ) {
    emit(SearchInitial());
  }
}
