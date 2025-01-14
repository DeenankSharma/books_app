import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:untitled1/features/home/ui/components/book_tile.dart';
import 'package:untitled1/features/search/bloc/search_bloc.dart';
import 'package:untitled1/features/search/bloc/search_event.dart';
import 'package:untitled1/features/search/bloc/search_state.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF3E2012),
            size: 32,
          ),
          onPressed: () {
            context.read<HomeBloc>().add(FetchBooksEvent());
            context.go('/home');
          },
        ),
        title: TextField(
          controller: _searchController,
          style: const TextStyle(
            color: Color(0xFF3E2012),
            fontSize: 18,
            fontFamily: 'Playfair Display',
          ),
          decoration: InputDecoration(
            hintText: 'Search books...',
            hintStyle: TextStyle(
              color: Colors.brown.shade700,
              fontSize: 18,
              fontFamily: 'Playfair Display',
            ),
            border: InputBorder.none,
            suffixIcon: IconButton(
              icon: const Icon(Icons.search_rounded, color: Color(0xFF3E2012)),
              onPressed: () {
                if (_searchController.text.trim().isNotEmpty) {
                  context
                      .read<SearchBloc>()
                      .add(SearchBooksEvent(_searchController.text));
                }
              },
            ),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              context.read<SearchBloc>().add(SearchBooksEvent(value));
            }
          },
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
        child: BlocConsumer<SearchBloc, SearchState>(
          listener: (context, state) {
            if (state is SearchErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                  backgroundColor: Colors.brown.shade900,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is SearchInitial) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.help_outline_rounded,
                      size: 100,
                      color: Colors.brown.shade900,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Search the book you are looking for',
                      style: TextStyle(
                        color: Colors.brown.shade900,
                        fontSize: 20,
                        fontFamily: 'Playfair Display',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (state is SearchLoading) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      color: Colors.brown.shade900,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Searching for books...',
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

            if (state is SearchSuccess) {
              return state.books.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off_rounded,
                            size: 64,
                            color: Colors.brown.shade900,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No books found',
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
                              context.go('/details', extra: {
                                'book': book,
                                'from_where': 'search'
                              });
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
