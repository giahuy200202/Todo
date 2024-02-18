import 'package:flutter/material.dart';
import 'package:todo/widgets/progress_widget.dart';
import 'package:todo/widgets/category_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/helpers/date_time.dart';

class HomeWidget extends ConsumerWidget {
  const HomeWidget({
    super.key,
  });

  int getNumOfTasks(List task, String category) {
    final dateTimeHelper = DateTimeHelper();
    var getToday = DateTime.now();
    var getFormatDate = DateTime(getToday.year, getToday.month, getToday.day);
    if (category == 'Today') {
      return task
          .where((t) =>
              dateTimeHelper.isSameDate(t.date, getFormatDate) &&
              !t.isCompleted)
          .toList()
          .length;
    } else if (category == 'Upcoming') {
      return task
          .where((t) => t.date.compareTo(getFormatDate) > 0 && !t.isCompleted)
          .toList()
          .length;
    } else if (category == 'Completed') {
      return task.where((t) => t.isCompleted).toList().length;
    } else {
      return task.length;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
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
                    "Homepage",
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
                title: "Today tasks",
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
      ),
    );
  }
}
