class TaskData {
  final String id;
  final List<String> field;
  final Map<String, int> startCoordinates;
  final Map<String, int> finishCoordinates;

  TaskData({
    required this.id,
    required this.field,
    required this.startCoordinates,
    required this.finishCoordinates,
  });

  factory TaskData.fromJsonData(Map<String, dynamic> jsonData) {
    return TaskData(
      id: jsonData['id'],
      field: (jsonData['field']).cast<String>(),
      startCoordinates: (jsonData['start']).cast<String, int>(),
      finishCoordinates: (jsonData['end']).cast<String, int>(),
    );
  }
}
