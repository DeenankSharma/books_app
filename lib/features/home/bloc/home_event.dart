part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class FetchBooksEvent extends HomeEvent {}

class LoadMoreBooksEvent extends HomeEvent {}
