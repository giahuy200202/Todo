import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/options_provider.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/models/task.dart';
import 'package:todo/notifications/local_notifications.dart';
import 'package:todo/helpers/date_time.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:todo/widgets/category_widget.dart';

class CreateScreen extends ConsumerStatefulWidget {
  const CreateScreen({super.key});

  @override
  ConsumerState<CreateScreen> createState() {
    return _CreateScreenState();
  }
}

class _CreateScreenState extends ConsumerState<CreateScreen> {
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController(
    text: 'Select date',
  );
  var timeController = TextEditingController(
    text: 'Select time',
  );

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    dateController.dispose();
    super.dispose();
  }

  void presentDatePicker() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: now,
      firstDate: now,
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      selectedDate = pickedDate;
    });
    dateController.text =
        DateFormat('dd/MM/yyyy').format(selectedDate!).toString();
  }

  void presentTimePicker() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: const ColorScheme.light(
                primary: Colors.black,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.black,
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.black, // button text color
                ),
              ),
            ),
            child: child!,
          ),
        );
      },
    );

    setState(() {
      selectedTime = pickedTime;
    });

    timeController.text = '${pickedTime!.hour}:${pickedTime.minute}';
  }

  int getNumOfTasks(List task, String category) {
    final dateTimeHelper = DateTimeHelper();
    var getToday = DateTime.now();
    var getFormatDate = DateTime(getToday.year, getToday.month, getToday.day);
    if (category == 'Today') {
      return task
          .where((t) =>
              dateTimeHelper.isSameDate(t.date, getFormatDate) &&
              !t.isCompleted)
          .toList()
          .length;
    } else if (category == 'Upcoming') {
      return task
          .where((t) => t.date.compareTo(getFormatDate) > 0 && !t.isCompleted)
          .toList()
          .length;
    } else if (category == 'Completed') {
      return task.where((t) => t.isCompleted).toList().length;
    } else {
      return task.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    final tasks = ref.watch(tasksProvider);

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
                    "Create New Task",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Title",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: TextField(
                  controller: titleController,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    hintText: 'Enter task\'s title',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 114, 111, 111),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Content",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 80,
                child: TextField(
                  controller: contentController,
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Colors.black),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 18,
                      horizontal: 15,
                    ),
                    hintText: 'Enter task\'s content',
                    hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 114, 111, 111),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Date",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 80,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: dateController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 15,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentDatePicker,
                                child:
                                    const Icon(Icons.calendar_month_outlined),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: 170,
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Time",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          height: 80,
                          child: TextField(
                            style: const TextStyle(
                              fontSize: 17,
                              color: Color.fromARGB(255, 114, 111, 111),
                              fontWeight: FontWeight.w500,
                            ),
                            readOnly: true,
                            controller: timeController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(9),
                                borderSide:
                                    const BorderSide(color: Colors.black),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 18,
                                horizontal: 15,
                              ),
                              suffixIcon: InkWell(
                                onTap: presentTimePicker,
                                child: const Icon(Icons.timer_sharp),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    if (titleController.text.trim().isEmpty ||
                        contentController.text.trim().isEmpty ||
                        selectedDate == null ||
                        selectedTime == null) {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: Colors.white,
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          )),
                          title: const Text('Invalid input'),
                          content: const Text(
                            'Please make sure a valid title, content, date and time was entered.',
                            style: TextStyle(
                              fontSize: 17,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                              },
                              child: const Text(
                                'Understood',
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      return;
                    }

                    ref.read(tasksProvider.notifier).createNewTask(Task(
                          id: (tasks.length + 1).toString(),
                          title: titleController.text,
                          content: contentController.text,
                          date: DateTime(
                              selectedDate!.year,
                              selectedDate!.month,
                              selectedDate!.day,
                              selectedTime!.hour,
                              selectedTime!.minute),
                          isCompleted: false,
                        ));

                    var getToday = DateTime.now();

                    final dateTimeHelper = DateTimeHelper();

                    var getFormatDate = DateTime(
                        getToday.year,
                        getToday.month,
                        getToday.day,
                        getToday.hour,
                        getToday.minute,
                        getToday.second);

                    print('-----------------');
                    print('getFormatDate');
                    print(getFormatDate);

                    int newMinute = selectedTime!.minute - 10;
                    int newHour = selectedTime!.hour;
                    if (newMinute < 0) {
                      newHour = selectedTime!.hour - 1;
                      newMinute = 60 + newMinute;
                    }

                    DateTime newDateTime = DateTime(
                      selectedDate!.year,
                      selectedDate!.month,
                      selectedDate!.day,
                      newHour,
                      newMinute,
                    );

                    Duration timeDifference =
                        newDateTime.difference(getFormatDate);

                    print('timeDifference');
                    print(timeDifference);

                    if (dateTimeHelper.isSameDate(
                            selectedDate!, getFormatDate) &&
                        newDateTime.compareTo(getFormatDate) > 0) {
                      int difHour = timeDifference.inHours > 0
                          ? timeDifference.inHours - 1
                          : timeDifference.inHours;

                      print('difHour');
                      print(difHour);

                      int difMin = timeDifference.inMinutes > 0
                          ? timeDifference.inMinutes - 1
                          : timeDifference.inMinutes;

                      print('difMin');
                      print(difMin);

                      int duration = difHour * 360 +
                          difMin * 60 +
                          timeDifference.inSeconds;

                      print('selectedTime!');
                      print(selectedTime!);

                      print('newDateTime');
                      print(newDateTime);

                      print(duration);

                      print('-----------------');

                      LocalNotifications.showScheduleNotification(
                        id: tasks.length + 1,
                        title: 'You have an impending task deadline',
                        body:
                            'Task\'s title: ${titleController.text}\nDeadline: ${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year} - ${selectedTime!.hour}:${selectedTime!.minute}',
                        payload: 'data',
                        duration: duration,
                      );
                    }
                    // print(tasks);
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        backgroundColor: Colors.white,
                        title: const Text('Success'),
                        content: const Text(
                          'Create new task successfully',
                          style: TextStyle(
                            fontSize: 17,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                              titleController.text = '';
                              contentController.text = '';
                              dateController.text = 'Select date';
                              timeController.text = 'Select time';
                            },
                            child: const Text(
                              'Ok',
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black, // background
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 18,
                      )), // foreground
                  child: const Text('Create'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
