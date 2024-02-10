import 'package:flutter/material.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'dart:async';

class TaskModal extends ConsumerStatefulWidget {
  const TaskModal({
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
  ConsumerState<TaskModal> createState() {
    return _TaskModalState();
  }
}

class _TaskModalState extends ConsumerState<TaskModal> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 2,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Color.fromARGB(255, 233, 236, 239),
          ),
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 110,
              padding: const EdgeInsets.only(left: 23, right: 20, top: 30),
              child: SizedBox(
                // width: 250,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment
                  //     .center, //Center Column contents vertically,
                  crossAxisAlignment: CrossAxisAlignment
                      .start, //Center Column contents horizontally,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.title,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.content,
                          // overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 73, 80, 87),
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_outlined,
                          size: 25,
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
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                          onPressed: widget.isCompleted || isChecked
                              ? null
                              : () {
                                  if (!widget.isCompleted) {
                                    setState(() {
                                      isChecked = true;
                                    });
                                    Timer(const Duration(seconds: 2), () {
                                      ref
                                          .read(tasksProvider.notifier)
                                          .markTaskCompleted(widget.id);
                                      Navigator.pop(context);
                                      setState(() {
                                        isChecked = false;
                                      });
                                    });
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black, // background
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(11),
                              ),
                              padding:
                                  const EdgeInsets.only(bottom: 14, top: 14),
                              textStyle: const TextStyle(
                                fontSize: 18,
                              )), // foreground
                          child: widget.isCompleted || isChecked
                              ? const Text('Completed')
                              : const Text('Mark as completed')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
