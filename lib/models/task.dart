class Task {
  Task({
    required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.category,
  });

  final String id;
  final String title;
  final String content;
  final DateTime date;
  String category;
}
