import 'package:flutter/material.dart';
import 'package:todo/widgets/progress_widget.dart';
import 'package:todo/widgets/category_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({
    super.key,
  });

  int getNumOfTasks(List task, String category) {
    return task
        .where((element) => element.category == category)
        .toList()
        .length;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            const Align(
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
            const ProgressSummary(),
            const SizedBox(height: 25),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Categories',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            CategoryDetail(
              title: "All tasks",
              icon: const Icon(Icons.list, size: 45),
              numOfTasks: getNumOfTasks(tasks, 'All').toString(),
            ),
            CategoryDetail(
              title: "Today's tasks",
              icon: const Icon(Icons.today, size: 45),
              numOfTasks: getNumOfTasks(tasks, 'Today').toString(),
            ),
            CategoryDetail(
              title: "Upcoming tasks",
              icon: const Icon(Icons.upcoming_outlined, size: 45),
              numOfTasks: getNumOfTasks(tasks, 'Upcoming').toString(),
            ),
            CategoryDetail(
              title: "Completed tasks",
              icon: const Icon(Icons.task_outlined, size: 45),
              numOfTasks: getNumOfTasks(tasks, 'Completed').toString(),
            ),
          ],
        ),
      ),
    );
  }
}
