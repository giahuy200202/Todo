import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrowseScreen extends ConsumerStatefulWidget {
  const BrowseScreen({super.key});

  @override
  ConsumerState<BrowseScreen> createState() {
    return _CreateScreenState();
  }
}

class _CreateScreenState extends ConsumerState<BrowseScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 40),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Browse",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 320),
                child: Text(
                  "Coming soon",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
