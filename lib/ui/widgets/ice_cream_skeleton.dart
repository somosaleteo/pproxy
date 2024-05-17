import 'package:flutter/material.dart';

class IceCreamSkeleton extends StatelessWidget {
  const IceCreamSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8.0),
      child: const CircularProgressIndicator(),
    );
  }
}
