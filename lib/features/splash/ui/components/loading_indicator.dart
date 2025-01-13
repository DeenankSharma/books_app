import 'package:flutter/material.dart';
import 'package:untitled1/features/home/bloc/home_bloc.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key, required this.state});
  final HomeState state;
  @override
  Widget build(BuildContext context) {
    if (state is HomeBooksFetchedErrorState) {
      return SizedBox(
        width: 40,
        height: 40,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Colors.red.shade700,
          ),
          strokeWidth: 3,
        ),
      );
    }

    return SizedBox(
      width: 40,
      height: 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          Colors.brown.shade900,
        ),
        strokeWidth: 3,
      ),
    );
  }
}
