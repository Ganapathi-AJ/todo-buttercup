import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  bool isCompleted;

  @HiveField(4)
  bool isPinned;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime? dueDate;

  @HiveField(7)
  String? category;

  @HiveField(8)
  int priority; // 0: Low, 1: Medium, 2: High

  Todo({
    String? id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.isPinned = false,
    DateTime? createdAt,
    this.dueDate,
    this.category,
    this.priority = 1,
  })  : id = id ?? const Uuid().v4(),
        createdAt = createdAt ?? DateTime.now();
} 