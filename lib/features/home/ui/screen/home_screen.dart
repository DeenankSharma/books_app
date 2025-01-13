import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:untitled1/features/home/ui/components/book_tile.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: const Icon(
          Icons.menu_book_rounded,
          color: const Color(0xFF3E2012),
          size: 32,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              size: 32,
              color: const Color(0xFF3E2012),
            ),
          )
        ],
        title: const Text(
          'Bookish',
          style: TextStyle(
            color: const Color(0xFF3E2012),
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: 'Playfair Display',
          ),
        ),
        backgroundColor: Colors.orange.shade300,
      ),
      body: Container(
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
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeFetchedBooksLoadingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.brown.shade900,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Loading your library...',
                      style: TextStyle(
                        color: Colors.brown.shade900,
                        fontFamily: 'Playfair Display',
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            }
            if (state is HomeBooksFetchedErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: Colors.brown.shade900,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Oops! Something went wrong',
                      style: TextStyle(
                        color: Colors.brown.shade900,
                        fontSize: 20,
                        fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<HomeBloc>().add(FetchBooksEvent());
                      },
                      icon: const Icon(Icons.refresh_rounded),
                      label: const Text('Try Again'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown.shade900,
                        foregroundColor: Colors.orange.shade100,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is HomeFetchedBooksState) {
              return state.books.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.library_books_outlined,
                            size: 64,
                            color: Colors.brown.shade900,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Library is empty',
                            style: TextStyle(
                              color: Colors.brown.shade900,
                              fontSize: 20,
                              fontFamily: 'Playfair Display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      itemCount: state.books.length,
                      itemBuilder: (context, index) {
                        final book = state.books[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BookTile(
                            title: book.title,
                            author: book.getPrimaryAuthorName(),
                            language: book.getPrimaryLanguage(),
                            coverImageUrl: book.getCoverImageUrl() ?? '',
                            onExpand: () {
                              context.go('/details', extra: book);
                            },
                          ),
                        );
                      },
                    );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
