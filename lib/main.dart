import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled1/features/details/bloc/details_bloc.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';
import 'package:untitled1/router/app_router_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<HomeBloc>(create: (context) => HomeBloc()),
          Provider<DetailsBloc>(create: (context) => DetailsBloc())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRouter.router,
        ));
  }
}
