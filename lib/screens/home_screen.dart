import 'package:flutter/material.dart';
import 'package:todo/providers/options_provider.dart';
import 'package:todo/widgets/home_widget.dart';
import 'package:todo/widgets/progress_widget.dart';
import 'package:todo/widgets/category_widget.dart';
import 'package:todo/screens/task_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/providers/tasks_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final options = ref.watch(optionsProvider);
    return options[Option.categoryOption] == ''
        ? const HomeWidget()
        : TaskScreen(option: options[Option.categoryOption]!);
  }
}