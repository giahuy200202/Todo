import 'package:flutter/material.dart';
import 'package:todo/screens/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/providers/options_provider.dart';

class CategoryDetail extends ConsumerWidget {
  const CategoryDetail({
    super.key,
    required this.title,
    required this.icon,
    required this.numOfTasks,
  });

  final String title;
  final Icon icon;
  final String numOfTasks;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(optionsProvider);
    return Container(
      margin: const EdgeInsets.only(top: 18),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Color.fromARGB(255, 233, 236, 239),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            final wasChanged = ref
                .read(optionsProvider.notifier)
                .setCategoryOption(title.split(' ')[0]);
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
                icon,
                const SizedBox(width: 25),
                SizedBox(
                  width: 250,
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment
                            .center, //Center Column contents vertically,
                        crossAxisAlignment: CrossAxisAlignment
                            .start, //Center Column contents horizontally,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              title,
                              style: const TextStyle(
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
                              numOfTasks,
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
    );
  }
}
