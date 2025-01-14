import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/data/models/book_model.dart';
import 'package:untitled1/features/details/bloc/details_bloc.dart';
import 'package:untitled1/features/details/ui/components/chip.dart';
import 'package:untitled1/features/details/ui/components/section.dart';
import 'package:untitled1/features/details/ui/components/statchip.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailsScreen extends StatelessWidget {
  const BookDetailsScreen({
    super.key,
    required this.book,
  });
  final BookModel book;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocConsumer<DetailsBloc, DetailsState>(
            listener: (context, state) async {
      if (state is DetailsErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.error,
              style: const TextStyle(
                  color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.brown.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      } else if (state is DownloadErrorState) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              state.error,
              style: const TextStyle(
                  color: Colors.amber, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.brown.shade900,
            behavior: SnackBarBehavior.floating,
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 3),
            action: SnackBarAction(
              label: 'Dismiss',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      } else if (state is ReadOnlineState) {
        try {
          final Uri url = Uri.parse(state.url);
          print(url);
          launchUrl(url).then((launched) {
            if (!launched) {
              context.read<DetailsBloc>().add(
                    ErrorEvent(
                      error: 'Could not open the online reader',
                      book: state.book,
                    ),
                  );
            }
          });
        } catch (e) {
          context.read<DetailsBloc>().add(
                ErrorEvent(
                  error: 'Invalid URL or unable to open online reader',
                  book: state.book,
                ),
              );
        }
      } else if (state is DownloadEpubState) {
        try {
          final Uri url = Uri.parse(state.url);
          // print(url);
          launchUrl(url).then((launched) {
            if (!launched) {
              context.read<DetailsBloc>().add(
                    DownloadErrorEvent(
                      error: 'Could not open the download link',
                      book: state.book,
                    ),
                  );
            }
          });
        } catch (e) {
          context.read<DetailsBloc>().add(
                DownloadErrorEvent(
                  error: 'Could not open the download link',
                  book: state.book,
                ),
              );
        }
      }
    }, builder: (context, state) {
      return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.orange.shade300,
              Colors.orange.shade500,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Bar
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context.read<HomeBloc>().add(FetchBooksEvent());
                          context.go('/home');
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.brown.shade900,
                        ),
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: book.getCoverImageUrl() != null
                            ? Image.network(
                                book.getCoverImageUrl()!,
                                height: 200,
                                width: 130,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  height: 200,
                                  width: 130,
                                  color: Colors.brown.shade200,
                                  child: Icon(
                                    Icons.book,
                                    size: 50,
                                    color: Colors.brown.shade900,
                                  ),
                                ),
                              )
                            : Container(
                                height: 200,
                                width: 130,
                                color: Colors.brown.shade200,
                                child: Icon(
                                  Icons.book,
                                  size: 50,
                                  color: Colors.brown.shade900,
                                ),
                              ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.title,
                              style: TextStyle(
                                color: Colors.brown.shade900,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Playfair Display',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'by ${book.getPrimaryAuthorName()}',
                              style: TextStyle(
                                color: Colors.brown.shade800,
                                fontSize: 16,
                                fontFamily: 'Playfair Display',
                              ),
                            ),
                            const SizedBox(height: 16),
                            StatChip_Component(
                              icon: Icons.download_rounded,
                              label: '${book.downloadCount} downloads',
                            ),
                            const SizedBox(height: 8),
                            StatChip_Component(
                              icon: Icons.language,
                              label: book.getPrimaryLanguage().toUpperCase(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                if (book.getHtmlUrl() != null || book.getEpubUrl() != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      children: [
                        if (book.getHtmlUrl() != null)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.read<DetailsBloc>().add(ReadOnlineEvent(
                                    book: book,
                                    link: book.formats['text/html'] as String));
                              },
                              icon: const Icon(
                                Icons.web_rounded,
                                color: Colors.amber,
                              ),
                              label: const Text('Read Online'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown.shade900,
                                foregroundColor: Colors.orange.shade100,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        if (book.getHtmlUrl() != null &&
                            book.getEpubUrl() != null)
                          const SizedBox(width: 12),
                        if (book.getEpubUrl() != null)
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.read<DetailsBloc>().add(
                                    DownloadEpubEvent(
                                        link:
                                            book.formats['application/epub+zip']
                                                as String,
                                        book: book));
                              },
                              icon: const Icon(
                                Icons.download_rounded,
                                color: Colors.amber,
                              ),
                              label: const Text('Download EPUB'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.brown.shade900,
                                foregroundColor: Colors.orange.shade100,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                const SizedBox(height: 24),
                Section(
                  title: 'Authors',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: book.authors.map((author) {
                      String authorText = author.name;
                      if (author.birthYear != null ||
                          author.deathYear != null) {
                        authorText +=
                            ' (${author.birthYear ?? '?'} - ${author.deathYear ?? '?'})';
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          authorText,
                          style: TextStyle(
                            color: Colors.brown.shade800,
                            fontSize: 16,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                if (book.translators.isNotEmpty)
                  Section(
                    title: 'Translators',
                    content: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: book.translators
                          .map(
                              (translator) => Chip_Component(label: translator))
                          .toList(),
                    ),
                  ),
                Section(
                  title: 'Subjects',
                  content: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: book.subjects
                        .map((subject) => Chip_Component(label: subject))
                        .toList(),
                  ),
                ),
                Section(
                  title: 'Bookshelves',
                  content: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: book.bookshelves
                        .map((bookshelf) => Chip_Component(label: bookshelf))
                        .toList(),
                  ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      );
    }));
  }
}
