import 'package:flutter/material.dart';
import 'package:todo/widgets/task_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/helpers/date_time.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() {
    return _CreateScreenState();
  }
}

class _CreateScreenState extends ConsumerState<NotificationScreen> {
  List<Task> listTask = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tasks = ref.watch(tasksProvider);

    final dateTimeHelper = DateTimeHelper();

    final leftColumnDiscoverData = ['flutter', 'react native', 'ux'];
    final rightColumnDiscoverData = ['animation', 'riverpod', 'http requests'];

    var getToday = DateTime.now();

    var getFormatDate = DateTime(getToday.year, getToday.month, getToday.day);

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
                    "Notifications",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                  height: 655,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ...tasks.map(
                          (task) => TaskWidget(
                            id: task.id,
                            title: task.title,
                            content: task.content,
                            date: dateTimeHelper.getDateFormatted(
                              task.date,
                              getFormatDate,
                              task.isCompleted,
                            ),
                            isCompleted: task.isCompleted,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
