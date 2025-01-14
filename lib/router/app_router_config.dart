import 'package:go_router/go_router.dart';
import 'package:untitled1/data/models/book_model.dart';
import 'package:untitled1/features/details/ui/screen/book_details_screen.dart';
import 'package:untitled1/features/home/ui/screen/home_screen.dart';
import 'package:untitled1/features/search/ui/screen/search_screen.dart';
import 'package:untitled1/features/splash/ui/screen/splash_screen.dart';

class AppRouter {
  AppRouter._();
  static final router = GoRouter(
    routes: [
      GoRoute(
          path: '/',
          name: 'splash',
          builder: (context, state) => SplashScreen()),
      GoRoute(
          path: '/home',
          name: 'home',
          builder: (context, state) => HomeScreen()),
      GoRoute(
          path: '/details',
          name: 'details',
          builder: (context, state) {
            final Map<String, dynamic> extras =
                state.extra as Map<String, dynamic>;
            final book = extras['book'] as BookModel;
            final fromWhere = extras['from_where'] as String;
            return BookDetailsScreen(
              book: book,
              from_where: fromWhere,
            );
          }),
      GoRoute(
          path: '/search',
          name: 'search',
          builder: (context, state) => SearchScreen()),
    ],
  );
}
