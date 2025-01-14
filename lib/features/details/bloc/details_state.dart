part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

final class DetailsInitial extends DetailsState {}

class BookDetailsState extends DetailsState {
  final BookModel book;

  BookDetailsState({required this.book});
}

class DetailsErrorState extends DetailsState {
  final String error;
  final BookModel book;

  DetailsErrorState({
    required this.error,
    required this.book,
  });
}

class DownloadErrorState extends DetailsState {
  final String error;
  final BookModel book;

  DownloadErrorState({
    required this.error,
    required this.book,
  });
}

class ReadOnlineState extends DetailsState {
  final String url;
  final BookModel book;

  ReadOnlineState({
    required this.url,
    required this.book,
  });
}

class DownloadEpubState extends DetailsState {
  final String url;
  final BookModel book;

  DownloadEpubState({
    required this.url,
    required this.book,
  });
}
