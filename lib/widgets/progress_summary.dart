import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';

class ProgressSummary extends ConsumerWidget {
  const ProgressSummary({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);
    int totalTasks = tasks.length;
    int completedTasks = tasks
        .where((element) => element.category == 'Completed')
        .toList()
        .length;
    double percentCompletedTasks = 1;

    if (totalTasks != 0) {
      percentCompletedTasks = (completedTasks / totalTasks).toDouble();
    }

    String stringtotalTasks =
        totalTasks > 1 ? '$totalTasks tasks' : '$totalTasks task';
    String stringCompletedTasks = 'Completed $completedTasks/$totalTasks';
    String stringPercentCompletedTasks = '${percentCompletedTasks * 100}%';
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 175,
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        image: DecorationImage(
          image: AssetImage("assets/images/black.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Progress summary',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              stringtotalTasks,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 17),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              stringCompletedTasks,
              style: const TextStyle(
                color: Colors.white,
                // fontSize: 15,
              ),
            ),
            const Spacer(),
            Text(
              stringPercentCompletedTasks,
              style: const TextStyle(
                color: Colors.white,
                // fontSize: 20,
              ),
            ),
          ]),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 400,
              height: 8,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: percentCompletedTasks,
                  backgroundColor: const Color.fromARGB(255, 118, 115, 115),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
