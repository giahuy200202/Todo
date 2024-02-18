import 'package:flutter/material.dart';
import 'package:todo/providers/tasks_provider.dart';
import 'package:todo/screens/layout_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/notifications/local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo/helpers/date_time.dart';
import 'package:intl/intl.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: Colors.black,
  ),
);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotifications.init();
  tz.initializeTimeZones();

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}

class App extends ConsumerStatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const LayoutScreen(),
    );
  }
}
