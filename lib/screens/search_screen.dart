import 'package:flutter/material.dart';
import 'package:todo/widgets/task_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/helpers/date_time.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() {
    return _CreateScreenState();
  }
}

class _CreateScreenState extends ConsumerState<SearchScreen> {
  var searchController = TextEditingController();

  List<Task> listTask = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var tasks = ref.watch(tasksProvider);

    final dateTimeHelper = DateTimeHelper();

    final leftColumnDiscoverData = ['flutter', 'react native', 'android'];
    final rightColumnDiscoverData = ['animation', 'riverpod', 'http requests'];

    var getToday = DateTime.now().toUtc();

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
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 45,
                child: TextField(
                  style: const TextStyle(
                    fontSize: 17,
                    color: Color.fromARGB(255, 114, 111, 111),
                    fontWeight: FontWeight.w500,
                  ),
                  controller: searchController,
                  textInputAction: TextInputAction.search,
                  onSubmitted: (value) {
                    setState(() {
                      listTask = tasks
                          .where(
                            (task) => (task.id.toLowerCase().contains(
                                    searchController.text.toLowerCase()) ||
                                task.title.toLowerCase().contains(
                                    searchController.text.toLowerCase()) ||
                                task.content.toLowerCase().contains(
                                    searchController.text.toLowerCase())),
                          )
                          .toList();
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15,
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() {
                          searchController.text = '';
                        });
                      },
                      child: const Icon(Icons.clear),
                    ),
                    hintText: 'Titles, Contents and More',
                    hintStyle: const TextStyle(
                        color: Color.fromARGB(255, 114, 111, 111),
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 580,
                child: searchController.text == ''
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Discover",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ...leftColumnDiscoverData.map(
                                      (data) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            searchController.text = data;
                                            listTask = tasks
                                                .where(
                                                  (task) => (task.id
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase()) ||
                                                      task.title
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase()) ||
                                                      task.content
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase())),
                                                )
                                                .toList();
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: SizedBox(
                                            width: 185,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.search),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  data,
                                                  style: const TextStyle(
                                                    fontSize: 16,
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
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ...rightColumnDiscoverData.map(
                                      (data) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            searchController.text = data;
                                            listTask = tasks
                                                .where(
                                                  (task) => (task.id
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase()) ||
                                                      task.title
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase()) ||
                                                      task.content
                                                          .toLowerCase()
                                                          .contains(data
                                                              .toLowerCase())),
                                                )
                                                .toList();
                                          });
                                        },
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 15),
                                          child: SizedBox(
                                            width: 175,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(Icons.search),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  data,
                                                  style: const TextStyle(
                                                    fontSize: 16,
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
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Suggested",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                      )
                    : listTask.isEmpty
                        ? const Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "No result",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                ...listTask.map(
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
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
