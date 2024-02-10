import 'package:flutter/material.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/options_provider.dart';
import 'dart:async';

class TaskWidget extends ConsumerStatefulWidget {
  const TaskWidget({
    super.key,
    required this.title,
    required this.content,
    required this.date,
    required this.id,
    required this.isCompleted,
  });

  final String title;
  final String content;
  final String date;
  final String id;
  final bool isCompleted;

  @override
  ConsumerState<TaskWidget> createState() {
    return _TaskWidgetState();
  }
}

class _TaskWidgetState extends ConsumerState<TaskWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);

    Icon icon = isChecked || widget.isCompleted
        ? const Icon(Icons.check_circle,
            size: 30, color: Color.fromARGB(255, 121, 123, 125))
        : const Icon(
            Icons.circle_outlined,
            size: 30,
            color: Color.fromARGB(255, 151, 153, 155),
          );

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(255, 233, 236, 239),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            ref
                .read(optionsProvider.notifier)
                .setCategoryOption(widget.title.split(' ')[0]);
          },
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 110,
            padding: const EdgeInsets.only(left: 23, right: 20),
            child: SizedBox(
              // width: 250,
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment
                        .center, //Center Column contents vertically,
                    crossAxisAlignment: CrossAxisAlignment
                        .start, //Center Column contents horizontally,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 260,
                            child: Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 260,
                            child: Text(
                              widget.content,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 73, 80, 87),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 5),
                          Align(
                            alignment: Alignment.topLeft,
                            child: SizedBox(
                              width: 235,
                              child: Text(
                                widget.date,
                                style: const TextStyle(
                                  color: Colors.black,
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      if (!widget.isCompleted) {
                        setState(() {
                          isChecked = true;
                        });
                        Timer(const Duration(seconds: 2), () {
                          ref
                              .read(tasksProvider.notifier)
                              .markTaskCompleted(widget.id);
                          setState(() {
                            isChecked = false;
                          });
                        });
                      }
                    },
                    child: icon,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
