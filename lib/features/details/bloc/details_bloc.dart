import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:untitled1/data/models/book_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<FetchBookDetailsEvent>(fetchBookDetailsEvent);
    on<ReadOnlineEvent>(readOnline);
    on<DownloadEpubEvent>(downloadEpub);
    on<DownloadErrorEvent>(downloadErrorEvent);
  }

  Future<void> readOnline(
      ReadOnlineEvent event, Emitter<DetailsState> emit) async {
    emit(ReadOnlineState(url: event.link, book: event.book));
  }

  Future<void> downloadErrorEvent(
      DownloadErrorEvent event, Emitter<DetailsState> emit) async {
    emit(DownloadErrorState(error: event.error, book: event.book));
  }

  Future<void> downloadEpub(
      DownloadEpubEvent event, Emitter<DetailsState> emit) async {
    emit(DownloadEpubState(url: event.link, book: event.book));
  }

  Future<void> fetchBookDetailsEvent(
      FetchBookDetailsEvent event, Emitter<DetailsState> emit) async {
    emit(BookDetailsState(book: event.book));
  }
}
