import 'package:flutter/foundation.dart' hide Category;
import '../models/category_model.dart';
import '../services/database_service.dart';

class CategoryProvider extends ChangeNotifier {
  final DatabaseService _databaseService;

  CategoryProvider(this._databaseService);

  List<Category> get categories => _databaseService.getAllCategories();

  Future<void> addCategory(Category category) async {
    await _databaseService.addCategory(category);
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    await _databaseService.updateCategory(category);
    notifyListeners();
  }

  Future<void> deleteCategory(String id) async {
    await _databaseService.deleteCategory(id);
    notifyListeners();
  }

  Category? getCategoryById(String? id) {
    if (id == null) return null;
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }
} 