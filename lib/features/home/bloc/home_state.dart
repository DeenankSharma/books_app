part of 'home_bloc.dart';

@immutable
abstract class HomeState {
  final List<BookModel> books;
  final bool isLoadingMore;

  const HomeState({
    this.books = const [],
    this.isLoadingMore = false,
  });
}

class HomeInitial extends HomeState {}

class HomeFetchedBooksState extends HomeState {
  const HomeFetchedBooksState({
    required List<BookModel> books,
    required bool isLoadingMore,
  }) : super(books: books, isLoadingMore: isLoadingMore);
}

class HomeFetchedBooksLoadingState extends HomeState {
  const HomeFetchedBooksLoadingState({
    required List<BookModel> books,
    required bool isLoadingMore,
  }) : super(books: books, isLoadingMore: isLoadingMore);
}

class HomeBooksFetchedErrorState extends HomeState {}

class LoadMoreBooksLoadingState extends HomeState {}

class LoadMoreBooksErrorState extends HomeState {
  final String error;

  LoadMoreBooksErrorState({required this.error});
}
