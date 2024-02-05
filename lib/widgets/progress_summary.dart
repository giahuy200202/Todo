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
      child: const Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Progress summary',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 5),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              '15 Tasks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
            ),
          ),
          SizedBox(height: 17),
          Row(mainAxisSize: MainAxisSize.min, children: [
            Text(
              'Completed 5/15',
              style: TextStyle(
                color: Colors.white,
                // fontSize: 15,
              ),
            ),
            Spacer(),
            Text(
              '30%',
              style: TextStyle(
                color: Colors.white,
                // fontSize: 20,
              ),
            ),
          ]),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topLeft,
            child: SizedBox(
              width: 400,
              height: 8,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: LinearProgressIndicator(
                  value: 0.3,
                  backgroundColor: Color.fromARGB(255, 118, 115, 115),
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
