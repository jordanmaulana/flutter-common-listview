import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class NextPageLoading extends StatelessWidget {
  const NextPageLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 16.0,
      left: 0.0,
      right: 0.0,
      child: LinearProgressIndicator(),
    );
  }
}
