import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:untitled1/features/splash/ui/components/loading_indicator.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {
        if (state is HomeFetchedBooksState) {
          context.go('/home');
        }
        if (state is HomeBooksFetchedErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Failed to load books. Retrying...'),
              backgroundColor: Colors.brown.shade600,
              behavior: SnackBarBehavior.floating,
            ),
          );
          // Future.delayed(const Duration(seconds: 15), () {
          //   if (context.mounted) {
          //     context.read<HomeBloc>().add(FetchBooksEvent());
          //   }
          // });
        }
      },
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeBloc>().add(FetchBooksEvent());
        }
        return Scaffold(
          body: Container(
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 200,
                    height: 200,
                    child: Image.asset(
                      'assets/book_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Bookish',
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: 'Playfair Display',
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade900,
                      shadows: [
                        Shadow(
                          color: Colors.brown.withOpacity(0.3),
                          offset: const Offset(2, 2),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'for the love of books',
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Playfair Display',
                      fontStyle: FontStyle.italic,
                      color: Colors.brown.shade700,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 48),
                  LoadingIndicator(
                    state: state,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
