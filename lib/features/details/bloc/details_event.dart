part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class FetchBookDetailsEvent extends DetailsEvent {
  final BookModel book;

  FetchBookDetailsEvent({required this.book});
}

class ReadOnlineEvent extends DetailsEvent {
  final String link;
  final BookModel book;

  ReadOnlineEvent({required this.link, required this.book});
}

class ErrorEvent extends DetailsEvent {
  final String error;
  final BookModel book;

  ErrorEvent({
    required this.error,
    required this.book,
  });
}

class DownloadEpubEvent extends DetailsEvent {
  final String link;
  final BookModel book;
  DownloadEpubEvent({required this.link, required this.book});
}

class DownloadErrorEvent extends DetailsEvent {
  final String error;
  final BookModel book;

  DownloadErrorEvent({
    required this.error,
    required this.book,
  });
}
