import 'package:flutter/material.dart';
import 'package:learn_grow_app/models/task.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [
    Task(id: '1', title: 'Completar módulo de Flutter', description: 'Terminar o curso introdutório', dueDate: DateTime.now().add(const Duration(days: 2))),
    Task(id: '2', title: 'Preparar apresentação', description: 'Slides para reunião de equipe', dueDate: DateTime.now().add(const Duration(days: 1))),
    Task(id: '3', title: 'Revisar artigo', isCompleted: true),
    Task(id: '4', title: 'Agendar reunião com mentor'),
  ];

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _selectedDate;

  void _addTask() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nova Tarefa',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descrição (opcional)',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text(
                    'Data de Vencimento:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(width: 8),
                  TextButton.icon(
                    icon: const Icon(Icons.calendar_today),
                    label: Text(
                      _selectedDate == null
                          ? 'Selecionar Data'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                    onPressed: () async {
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          _selectedDate = pickedDate;
                        });
                      }
                    },
                  ),
                  if (_selectedDate != null)
                    IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        setState(() {
                          _selectedDate = null;
                        });
                      },
                    ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _titleController.clear();
                      _descriptionController.clear();
                      _selectedDate = null;
                    },
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.trim().isEmpty) {
                        return;
                      }
                      setState(() {
                        _tasks.add(
                          Task(
                            id: DateTime.now().toString(),
                            title: _titleController.text.trim(),
                            description: _descriptionController.text.trim().isEmpty
                                ? null
                                : _descriptionController.text.trim(),
                            dueDate: _selectedDate,
                          ),
                        );
                      });
                      Navigator.of(context).pop();
                      _titleController.clear();
                      _descriptionController.clear();
                      _selectedDate = null;
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _toggleTaskStatus(String id) {
    setState(() {
      final taskIndex = _tasks.indexWhere((task) => task.id == id);
      if (taskIndex != -1) {
        _tasks[taskIndex] = _tasks[taskIndex].copyWith(
          isCompleted: !_tasks[taskIndex].isCompleted,
        );
      }
    });
  }

  void _deleteTask(String id) {
    setState(() {
      _tasks.removeWhere((task) => task.id == id);
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTasks = _tasks.where((task) => !task.isCompleted).toList();
    final completedTasks = _tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Tarefas'),
      ),
      body: _tasks.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.task_alt,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Nenhuma tarefa adicionada',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton.icon(
                    onPressed: _addTask,
                    icon: const Icon(Icons.add),
                    label: const Text('Adicionar Tarefa'),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (activeTasks.isNotEmpty) ...[
                  Text(
                    'Tarefas Ativas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...activeTasks.map((task) => _buildTaskItem(task)),
                  const SizedBox(height: 24),
                ],
                if (completedTasks.isNotEmpty) ...[
                  Text(
                    'Tarefas Concluídas',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...completedTasks.map((task) => _buildTaskItem(task)),
                ],
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildTaskItem(Task task) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (_) => _toggleTaskStatus(task.id),
              activeColor: Colors.teal,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      color: task.isCompleted ? Colors.grey : null,
                    ),
                  ),
                  if (task.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      task.description!,
                      style: TextStyle(
                        fontSize: 14,
                        color: task.isCompleted ? Colors.grey : Colors.grey.shade700,
                        decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                      ),
                    ),
                  ],
                  if (task.dueDate != null) ...[
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14,
                          color: task.isCompleted ? Colors.grey : Colors.grey.shade700,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}',
                          style: TextStyle(
                            fontSize: 12,
                            color: task.isCompleted ? Colors.grey : Colors.grey.shade700,
                            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _deleteTask(task.id),
              color: Colors.red.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
