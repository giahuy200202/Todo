import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:todo/models/notification_element.dart';

class NotificationElementsNotifier
    extends StateNotifier<List<NotificationElement>> {
  NotificationElementsNotifier() : super([]);

  bool createNewNotificationElement(NotificationElement notificationElement) {
    state = [...state, notificationElement];
    return true;
  }
}

final notificationElementsProvider = StateNotifierProvider<
    NotificationElementsNotifier, List<NotificationElement>>((ref) {
  return NotificationElementsNotifier();
});
