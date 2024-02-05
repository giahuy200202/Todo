import 'package:flutter/material.dart';
import 'package:todo/widgets/progress_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 10),
          ProgressSummary(),
        ],
      ),
    );
  }
}
