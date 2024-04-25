class TodoModel {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;

  TodoModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.isCompleted});

  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
      id: jsonData['id'],
      title: jsonData['title'],
      description: jsonData['description'],
      isCompleted: jsonData['isCompleted'],
    );
  }
}
