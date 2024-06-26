import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/models/task.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() {
    return _CreateScreenState();
  }
}

class _CreateScreenState extends ConsumerState<ProfileScreen> {
  List<Task> listTask = [];

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
                    "Profile",
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
