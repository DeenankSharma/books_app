import 'package:equatable/equatable.dart';
import 'package:untitled1/data/models/book_model.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchSuccess extends SearchState {
  final List<BookModel> books;
  const SearchSuccess(this.books);

  @override
  List<Object> get props => [books];
}

class SearchErrorState extends SearchState {
  final String error;
  const SearchErrorState(this.error);

  @override
  List<Object> get props => [error];
}
