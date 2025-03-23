import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' hide Category;
import '../models/todo_model.dart';
import '../models/category_model.dart';
import '../providers/theme_provider.dart';

class DatabaseService {
  static const String todoBoxName = 'todos';
  static const String categoryBoxName = 'categories';

  Future<void> initializeHive() async {
    if (!kIsWeb) {
      final appDocumentDirectory = await getApplicationDocumentsDirectory();
      Hive.init(appDocumentDirectory.path);
    } else {
      await Hive.initFlutter();
    }

    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TodoAdapter());
    }
    
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(CategoryAdapter());
    }

    // Open boxes
    await Hive.openBox<Todo>(todoBoxName);
    await Hive.openBox<Category>(categoryBoxName);
    await Hive.openBox<bool>(ThemeProvider.themeBoxName);
  }

  // Todo CRUD operations
  Box<Todo> get todoBox => Hive.box<Todo>(todoBoxName);

  List<Todo> getAllTodos() {
    return todoBox.values.toList();
  }

  Future<void> addTodo(Todo todo) async {
    await todoBox.put(todo.id, todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await todoBox.put(todo.id, todo);
  }

  Future<void> deleteTodo(String id) async {
    await todoBox.delete(id);
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todo = todoBox.get(id);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      await todoBox.put(id, todo);
    }
  }

  Future<void> toggleTodoPin(String id) async {
    final todo = todoBox.get(id);
    if (todo != null) {
      todo.isPinned = !todo.isPinned;
      await todoBox.put(id, todo);
    }
  }

  // Category CRUD operations
  Box<Category> get categoryBox => Hive.box<Category>(categoryBoxName);

  List<Category> getAllCategories() {
    return categoryBox.values.toList();
  }

  Future<void> addCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }

  Future<void> updateCategory(Category category) async {
    await categoryBox.put(category.id, category);
  }

  Future<void> deleteCategory(String id) async {
    await categoryBox.delete(id);
  }

  // Filtered todo operations
  List<Todo> getTodosByCategory(String categoryId) {
    return todoBox.values.where((todo) => todo.category == categoryId).toList();
  }

  List<Todo> getCompletedTodos() {
    return todoBox.values.where((todo) => todo.isCompleted).toList();
  }

  List<Todo> getActiveTodos() {
    return todoBox.values.where((todo) => !todo.isCompleted).toList();
  }

  List<Todo> getPinnedTodos() {
    return todoBox.values.where((todo) => todo.isPinned).toList();
  }

  List<Todo> getTodosByPriority(int priority) {
    return todoBox.values.where((todo) => todo.priority == priority).toList();
  }

  List<Todo> getTodosWithDueDate() {
    return todoBox.values.where((todo) => todo.dueDate != null).toList();
  }

  List<Todo> getTodosWithDueDateToday() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return todoBox.values.where((todo) {
      if (todo.dueDate == null) return false;
      final dueDate = DateTime(
        todo.dueDate!.year,
        todo.dueDate!.month,
        todo.dueDate!.day,
      );
      return dueDate.isAtSameMomentAs(today);
    }).toList();
  }

  // Search operations
  List<Todo> searchTodos(String query) {
    final lowercaseQuery = query.toLowerCase();
    return todoBox.values.where((todo) {
      return todo.title.toLowerCase().contains(lowercaseQuery) ||
          todo.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
} 