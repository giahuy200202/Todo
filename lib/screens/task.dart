import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/options_provider.dart';

class TaskScreen extends ConsumerWidget {
  const TaskScreen({
    super.key,
    required this.option,
  });

  final String option;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String titleScreen = '$option tasks';
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
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          final wasChanged = ref
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
                        child: Text(
                          titleScreen,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 18),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                color: Color.fromARGB(255, 233, 236, 239),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final a = DateTime(2024, 2, 9);
                    final b = DateTime(2024, 2, 10);
                    print(a.compareTo(b));
                  },
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 85,
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        const Icon(Icons.abc),
                        const SizedBox(width: 25),
                        SizedBox(
                          width: 270,
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, //Center Column contents vertically,
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, //Center Column contents horizontally,
                                children: [
                                  const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'aaa',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 19,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'xyz',
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 73, 80, 87),
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios_sharp,
                                size: 25,
                                color: Color.fromARGB(255, 151, 153, 155),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
