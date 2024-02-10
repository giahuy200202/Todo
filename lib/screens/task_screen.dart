import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/options_provider.dart';
import 'package:todo/widgets/task_widget.dart';
import 'package:intl/intl.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({
    super.key,
    required this.option,
  });

  final String option;

  String getDateFormatted(DateTime date, DateTime today, bool isCompleted) {
    if (date.compareTo(today) == 0 && !isCompleted) {
      return 'Today - ${DateFormat("dd/MM/yyyy").format(date).toString()}';
    } else if (date.compareTo(today) > 0 && !isCompleted) {
      return 'Upcoming - ${DateFormat("dd/MM/yyyy").format(date).toString()}';
    } else if (date.compareTo(today) < 0 && !isCompleted) {
      return 'Overdue - ${DateFormat("dd/MM/yyyy").format(date).toString()}';
    }
    return 'Completed';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String titleScreen = '$option tasks';

    String stringDeadline = '';

    var tasks = ref.watch(tasksProvider);

    var getToday = DateTime.now().toUtc();

    var getFormatDate = DateTime(getToday.year, getToday.month, getToday.day);

    if (option == 'Today') {
      tasks = tasks
          .where((t) => t.date.compareTo(getFormatDate) == 0 && !t.isCompleted)
          .toList();
    } else if (option == 'Upcoming') {
      tasks = tasks
          .where((t) => t.date.compareTo(getFormatDate) > 0 && !t.isCompleted)
          .toList();
    } else if (option == 'Completed') {
      tasks = tasks.where((t) => t.isCompleted).toList();
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 40),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            ref
                                .read(optionsProvider.notifier)
                                .setCategoryOption('');
                          },
                          child: const Icon(
                            Icons.arrow_back_ios_sharp,
                            size: 22,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 200,
                            child: Text(
                              titleScreen,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 652,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...tasks.map((task) => TaskWidget(
                          id: task.id,
                          title: task.title,
                          content: task.content,
                          date: getDateFormatted(
                              task.date, getFormatDate, task.isCompleted),
                          isCompleted: task.isCompleted,
                        ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
