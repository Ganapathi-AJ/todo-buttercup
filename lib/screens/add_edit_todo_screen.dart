import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
import '../models/todo_model.dart';
import '../providers/todo_provider.dart';
import '../providers/category_provider.dart';
import '../constants/app_constants.dart';

class AddEditTodoScreen extends StatefulWidget {
  final Todo? todo;
  
  const AddEditTodoScreen({Key? key, this.todo}) : super(key: key);

  @override
  State<AddEditTodoScreen> createState() => _AddEditTodoScreenState();
}

class _AddEditTodoScreenState extends State<AddEditTodoScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  String? _selectedCategoryId;
  DateTime? _dueDate;
  int _priority = 1;
  bool _isPinned = false;
  bool _isEditing = false;
  
  @override
  void initState() {
    super.initState();
    _isEditing = widget.todo != null;
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController = TextEditingController(text: widget.todo?.description ?? '');
    _selectedCategoryId = widget.todo?.category;
    _dueDate = widget.todo?.dueDate;
    _priority = widget.todo?.priority ?? 1;
    _isPinned = widget.todo?.isPinned ?? false;
  }
  
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  
  void _saveTodo() {
    if (_formKey.currentState!.validate()) {
      final todoProvider = Provider.of<TodoProvider>(context, listen: false);
      
      if (_isEditing) {
        // Update existing todo
        final updatedTodo = Todo(
          id: widget.todo!.id,
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          isCompleted: widget.todo!.isCompleted,
          isPinned: _isPinned,
          createdAt: widget.todo!.createdAt,
          dueDate: _dueDate,
          category: _selectedCategoryId,
          priority: _priority,
        );
        
        todoProvider.updateTodo(updatedTodo);
      } else {
        // Create new todo
        final newTodo = Todo(
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          isPinned: _isPinned,
          dueDate: _dueDate,
          category: _selectedCategoryId,
          priority: _priority,
        );
        
        todoProvider.addTodo(newTodo);
      }
      
      Navigator.pop(context);
    }
  }
  
  Future<void> _selectDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Theme.of(context).colorScheme.primary,
            ),
          ),
          child: child!,
        );
      },
    );
    
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: _dueDate != null
            ? TimeOfDay.fromDateTime(_dueDate!)
            : TimeOfDay.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: Theme.of(context).colorScheme.copyWith(
                primary: Theme.of(context).colorScheme.primary,
              ),
            ),
            child: child!,
          );
        },
      );
      
      if (pickedTime != null) {
        setState(() {
          _dueDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }
  
  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categories;
    
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Task' : 'Add New Task'),
        actions: [
          IconButton(
            onPressed: _saveTodo,
            icon: const Icon(Icons.check),
            tooltip: 'Save',
          ),
        ],
      ),
      body: FadeInUp(
        duration: const Duration(milliseconds: 300),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Title Field
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  prefixIcon: Icon(Icons.title),
                ),
                maxLength: AppConstants.titleMaxLength,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 16),
              
              // Description Field
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  prefixIcon: Icon(Icons.description),
                  alignLabelWithHint: true,
                ),
                maxLength: AppConstants.descriptionMaxLength,
                maxLines: 5,
                minLines: 3,
                textInputAction: TextInputAction.newline,
              ),
              const SizedBox(height: 16),
              
              // Priority Selector
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Priority',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SegmentedButton<int>(
                    segments: const [
                      ButtonSegment<int>(
                        value: 0,
                        label: Text('Low'),
                        icon: Icon(Icons.arrow_downward),
                      ),
                      ButtonSegment<int>(
                        value: 1,
                        label: Text('Medium'),
                        icon: Icon(Icons.remove),
                      ),
                      ButtonSegment<int>(
                        value: 2,
                        label: Text('High'),
                        icon: Icon(Icons.arrow_upward),
                      ),
                    ],
                    selected: {_priority},
                    onSelectionChanged: (Set<int> newSelection) {
                      setState(() {
                        _priority = newSelection.first;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return _priority == 0
                                ? AppConstants.lowPriorityColor
                                : _priority == 1
                                    ? AppConstants.mediumPriorityColor
                                    : AppConstants.highPriorityColor;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Due Date Selector
              ListTile(
                title: const Text('Due Date'),
                subtitle: Text(
                  _dueDate != null
                      ? DateFormat('MMM dd, yyyy - hh:mm a').format(_dueDate!)
                      : 'No due date set',
                ),
                leading: const Icon(Icons.event),
                trailing: _dueDate != null
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            _dueDate = null;
                          });
                        },
                      )
                    : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
                  ),
                ),
                onTap: () => _selectDueDate(context),
              ),
              const SizedBox(height: 16),
              
              // Category Selector
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Navigation to create category screen would go here
                          // We'll implement it in another file
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('New Category'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (categories.isEmpty)
                    const Text('No categories available')
                  else
                    SizedBox(
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final category = categories[index];
                          final isSelected = category.id == _selectedCategoryId;
                          final categoryColor = Color(int.parse(category.colorHex));
                          
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(category.name),
                              selected: isSelected,
                              backgroundColor: categoryColor.withOpacity(0.1),
                              selectedColor: categoryColor.withOpacity(0.3),
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? categoryColor
                                    : categoryColor.withOpacity(0.8),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  _selectedCategoryId = selected ? category.id : null;
                                });
                              },
                              avatar: Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: categoryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Pin Toggle
              SwitchListTile(
                title: const Text('Pin this task'),
                subtitle: const Text('Pinned tasks appear at the top'),
                value: _isPinned,
                onChanged: (value) {
                  setState(() {
                    _isPinned = value;
                  });
                },
                secondary: Icon(
                  _isPinned ? Icons.push_pin : Icons.push_pin_outlined,
                  color: _isPinned ? Colors.amber : null,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
            onPressed: _saveTodo,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              _isEditing ? 'Update Task' : 'Add Task',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
} 