import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/models/task.dart';

class TasksNotifier extends StateNotifier<List<Task>> {
  TasksNotifier() : super([]);

  bool createNewTask(Task task) {
    if (state.isNotEmpty) {
      final listTaskExist = state.where((t) => t.id != task.id);
      if (listTaskExist.isEmpty) {
        state = [...state, task];
        return true;
      }
    } else {
      state = [...state, task];
      return true;
    }
    return false;
  }

  bool markTaskCompleted(String id) {
    if (state.isNotEmpty) {
      for (var i = 0; i < state.length; i++) {
        if (state[i].id == id) {
          state[i].category = "Completed";
          return true;
        } else {
          return false;
        }
      }
    }
    return false;
  }

  bool deleteTask(String id) {
    if (state.isNotEmpty) {
      state = state.where((t) => t.id != id).toList();
      return true;
    }
    return false;
  }
}

final tasksProvider = StateNotifierProvider<TasksNotifier, List<Task>>((ref) {
  return TasksNotifier();
});
