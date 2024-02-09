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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String titleScreen = '$option tasks';
    var tasks = ref.watch(tasksProvider);
    tasks = option == 'All'
        ? tasks.toList()
        : tasks.where((t) => t.category == option).toList();
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
                          date: option == 'Completed'
                              ? 'Completed'
                              : 'Due in ${DateFormat("dd-MM-yyyy").format(task.date).toString()}',
                          category: task.category,
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
