part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

final class HomeInitial extends HomeState {}

class HomeFetchedBooksState extends HomeState {
  final List<BookModel> books;
  HomeFetchedBooksState({required this.books});
}

class HomeFetchedBooksLoadingState extends HomeState {}

class HomeBooksFetchedErrorState extends HomeState {}
