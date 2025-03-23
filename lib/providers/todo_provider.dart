import 'package:flutter/foundation.dart';
import '../models/todo_model.dart';
import '../services/database_service.dart';

enum TodoFilter { all, active, completed, pinned, today, withDueDate }

class TodoProvider extends ChangeNotifier {
  final DatabaseService _databaseService;
  TodoFilter _currentFilter = TodoFilter.all;
  String? _selectedCategory;
  String _searchQuery = '';

  TodoProvider(this._databaseService);

  // Getters
  TodoFilter get currentFilter => _currentFilter;
  String? get selectedCategory => _selectedCategory;
  String get searchQuery => _searchQuery;

  // Filter todos based on current settings
  List<Todo> get filteredTodos {
    List<Todo> result = [];

    // Apply category filter first
    if (_selectedCategory != null) {
      result = _databaseService.getTodosByCategory(_selectedCategory!);
    } else {
      // Apply main filter
      switch (_currentFilter) {
        case TodoFilter.all:
          result = _databaseService.getAllTodos();
          break;
        case TodoFilter.active:
          result = _databaseService.getActiveTodos();
          break;
        case TodoFilter.completed:
          result = _databaseService.getCompletedTodos();
          break;
        case TodoFilter.pinned:
          result = _databaseService.getPinnedTodos();
          break;
        case TodoFilter.today:
          result = _databaseService.getTodosWithDueDateToday();
          break;
        case TodoFilter.withDueDate:
          result = _databaseService.getTodosWithDueDate();
          break;
      }
    }

    // Apply search filter if there's a query
    if (_searchQuery.isNotEmpty) {
      result = result.where((todo) {
        final title = todo.title.toLowerCase();
        final description = todo.description.toLowerCase();
        final query = _searchQuery.toLowerCase();
        return title.contains(query) || description.contains(query);
      }).toList();
    }

    // Sort result: pinned first, then by due date, then by creation date (newest first)
    result.sort((a, b) {
      // Pinned items first
      if (a.isPinned && !b.isPinned) return -1;
      if (!a.isPinned && b.isPinned) return 1;

      // Sort by due date if both have due dates
      if (a.dueDate != null && b.dueDate != null) {
        return a.dueDate!.compareTo(b.dueDate!);
      }

      // Items with due dates come before those without
      if (a.dueDate != null && b.dueDate == null) return -1;
      if (a.dueDate == null && b.dueDate != null) return 1;

      // Finally sort by creation date (newest first)
      return b.createdAt.compareTo(a.createdAt);
    });

    return result;
  }

  // Filter setters
  void setFilter(TodoFilter filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  void setCategory(String? categoryId) {
    _selectedCategory = categoryId;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void clearFilters() {
    _currentFilter = TodoFilter.all;
    _selectedCategory = null;
    _searchQuery = '';
    notifyListeners();
  }

  // CRUD operations
  Future<void> addTodo(Todo todo) async {
    await _databaseService.addTodo(todo);
    notifyListeners();
  }

  Future<void> updateTodo(Todo todo) async {
    await _databaseService.updateTodo(todo);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    await _databaseService.deleteTodo(id);
    notifyListeners();
  }

  Future<void> toggleTodoCompletion(String id) async {
    await _databaseService.toggleTodoCompletion(id);
    notifyListeners();
  }

  Future<void> toggleTodoPin(String id) async {
    await _databaseService.toggleTodoPin(id);
    notifyListeners();
  }

  // Analytics and stats
  int get todoCount => _databaseService.getAllTodos().length;
  int get completedTodoCount => _databaseService.getCompletedTodos().length;
  int get activeTodoCount => _databaseService.getActiveTodos().length;
  int get pinnedTodoCount => _databaseService.getPinnedTodos().length;
  
  double get completionRate {
    final total = todoCount;
    if (total == 0) return 0.0;
    return completedTodoCount / total;
  }
} 