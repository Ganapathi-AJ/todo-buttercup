import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:animate_do/animate_do.dart';
import '../models/todo_model.dart';
import '../constants/app_constants.dart';
import '../utils/date_util.dart';
import '../providers/category_provider.dart';
import '../providers/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final VoidCallback? onTap;
  final int index;
  
  const TodoItem({
    Key? key,
    required this.todo,
    this.onTap,
    required this.index,
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final todoProvider = Provider.of<TodoProvider>(context);
    
    final category = categoryProvider.getCategoryById(todo.category);
    final Color categoryColor = category != null
        ? Color(int.parse(category.colorHex))
        : Theme.of(context).colorScheme.primary;
        
    final Color priorityColor = todo.priority == 0
        ? AppConstants.lowPriorityColor
        : todo.priority == 1
            ? AppConstants.mediumPriorityColor
            : AppConstants.highPriorityColor;
    
    return FadeInUp(
      delay: Duration(milliseconds: 50 * index),
      duration: AppConstants.mediumAnimationDuration,
      child: Slidable(
        key: ValueKey(todo.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          dismissible: DismissiblePane(
            onDismissed: () => todoProvider.deleteTodo(todo.id),
          ),
          children: [
            SlidableAction(
              onPressed: (_) => todoProvider.toggleTodoCompletion(todo.id),
              backgroundColor: todo.isCompleted
                  ? Colors.orange
                  : Colors.green,
              foregroundColor: Colors.white,
              icon: todo.isCompleted ? Icons.replay : Icons.check,
              label: todo.isCompleted ? 'Undo' : 'Complete',
              borderRadius: const BorderRadius.horizontal(left: Radius.circular(12)),
            ),
            SlidableAction(
              onPressed: (_) => todoProvider.deleteTodo(todo.id),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: const BorderRadius.horizontal(right: Radius.circular(12)),
            ),
          ],
        ),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    categoryColor.withOpacity(0.05),
                    categoryColor.withOpacity(0.15),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Priority indicator
                      Container(
                        height: 20,
                        width: 4,
                        decoration: BoxDecoration(
                          color: priorityColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                        margin: const EdgeInsets.only(right: 8, top: 2),
                      ),
                      // Title & Description
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // Category pill
                                if (category != null) ...[
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: categoryColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      category.name,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: categoryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                ],
                                if (todo.isPinned) ...[
                                  const Icon(
                                    Icons.push_pin,
                                    size: 16,
                                    color: Colors.amber,
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              todo.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: todo.isCompleted
                                    ? TextDecoration.lineThrough
                                    : null,
                                color: todo.isCompleted
                                    ? Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6)
                                    : Theme.of(context).textTheme.bodyLarge?.color,
                              ),
                            ),
                            if (todo.description.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                todo.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.8),
                                  decoration: todo.isCompleted
                                      ? TextDecoration.lineThrough
                                      : null,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      
                      // Checkbox
                      Checkbox(
                        value: todo.isCompleted,
                        onChanged: (_) => todoProvider.toggleTodoCompletion(todo.id),
                        activeColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),
                  
                  // Footer with date and buttons
                  Row(
                    children: [
                      // Creation date
                      Expanded(
                        child: Text(
                          DateUtil.getRelativeTime(todo.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.6),
                          ),
                        ),
                      ),
                      
                      // Due date
                      if (todo.dueDate != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: _getDueDateColor(todo.dueDate).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.event,
                                size: 12,
                                color: _getDueDateColor(todo.dueDate),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                DateUtil.getDueStatus(todo.dueDate),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: _getDueDateColor(todo.dueDate),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      
                      // Pin button
                      IconButton(
                        onPressed: () => todoProvider.toggleTodoPin(todo.id),
                        icon: Icon(
                          todo.isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                          size: 20,
                        ),
                        color: todo.isPinned ? Colors.amber : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  Color _getDueDateColor(DateTime? dueDate) {
    if (dueDate == null) return Colors.grey;
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dueDateDay = DateTime(dueDate.year, dueDate.month, dueDate.day);
    
    final difference = dueDateDay.difference(today).inDays;
    
    if (difference < 0) {
      return Colors.red; // Overdue
    } else if (difference == 0) {
      return Colors.orange; // Due today
    } else if (difference <= 3) {
      return Colors.amber; // Due soon
    } else {
      return Colors.green; // Due later
    }
  }
} 