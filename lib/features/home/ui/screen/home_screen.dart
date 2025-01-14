import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:untitled1/features/home/ui/components/book_tile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
    context.read<HomeBloc>().add(FetchBooksEvent());
  }

  void _onScroll() {
    if (_controller.position.pixels >=
        _controller.position.maxScrollExtent - 100) {
      final state = context.read<HomeBloc>().state;
      if (state is HomeFetchedBooksState && !state.isLoadingMore) {
        context.read<HomeBloc>().add(LoadMoreBooksEvent());
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
            onPressed: () {
              context.go('/search');
            },
            icon: const Icon(
              Icons.search_rounded,
              size: 32,
              color: const Color(0xFF3E2012),
            ),
          )
        ],
        title: const Text(
          'BookHive',
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
        child: BlocConsumer<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state is LoadMoreBooksLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Loading more books...'),
                  duration: Duration(milliseconds: 500),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeFetchedBooksLoadingState && state.books.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.brown,
                )),
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

            if (state is HomeFetchedBooksState ||
                state is HomeFetchedBooksLoadingState) {
              final books = state is HomeFetchedBooksState
                  ? state.books
                  : (state as HomeFetchedBooksLoadingState).books;

              return books.isEmpty
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
                      controller: _controller,
                      itemCount: books.length + (state.isLoadingMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == books.length) {
                          return const Center(
                              child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.brown,
                              ),
                            ),
                          ));
                        }

                        final book = books[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: BookTile(
                            title: book.title,
                            author: book.getPrimaryAuthorName(),
                            language: book.getPrimaryLanguage(),
                            coverImageUrl: book.getCoverImageUrl() ?? '',
                            onExpand: () {
                              context.go('/details',
                                  extra: {'book': book, 'from_where': 'home'});
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
