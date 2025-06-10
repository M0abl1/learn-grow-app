import 'package:flutter/material.dart';
import 'package:learn_grow_app/data/mock_events.dart';
import 'package:learn_grow_app/models/event.dart' as model;
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  late DateTime _focusedDay;
  late DateTime _selectedDay;
  late CalendarFormat _calendarFormat;
  late Map<DateTime, List<model.Event>> _events;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _calendarFormat = CalendarFormat.month;
    _loadEvents();
  }

  void _loadEvents() {
    _events = {};
    for (var event in mockEvents) {
      final date = DateTime(event.date.year, event.date.month, event.date.day);
      if (_events[date] != null) {
        _events[date]!.add(event);
      } else {
        _events[date] = [event];
      }
    }
  }

  List<model.Event> _getEventsForDay(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return _events[date] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendário'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            eventLoader: _getEventsForDay,
            calendarStyle: const CalendarStyle(
              markersMaxCount: 3,
              markerDecoration: BoxDecoration(
                color: Colors.teal,
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonTextStyle: TextStyle(fontSize: 14.0),
              titleCentered: true,
              formatButtonShowsNext: false,
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToEventEditor(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEventList() {
    final events = _getEventsForDay(_selectedDay);
    
    if (events.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.event_available,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'Nenhum evento para ${_formatDate(_selectedDay)}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () => _navigateToEventEditor(context),
              icon: const Icon(Icons.add),
              label: const Text('Adicionar Evento'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () => _navigateToEventEditor(context, event),
            borderRadius: BorderRadius.circular(10),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 80,
                    decoration: BoxDecoration(
                      color: convertToMaterialColor(event.color ?? model.Color.teal),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                event.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_outline),
                              onPressed: () => _deleteEvent(event.id),
                              color: Colors.red.shade300,
                              iconSize: 20,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        if (event.description != null && event.description!.isNotEmpty)
                          Text(
                            event.description!,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 16,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              event.startTime != null && event.endTime != null
                                  ? '${event.startTime} - ${event.endTime}'
                                  : 'Todo o dia',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  void _navigateToEventEditor(BuildContext context, [model.Event? event]) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventEditorScreen(
          selectedDate: _selectedDay,
          event: event,
        ),
      ),
    );

    if (result == true) {
      setState(() {
        _loadEvents();
      });
    }
  }

  void _deleteEvent(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Excluir Evento'),
        content: const Text('Tem certeza que deseja excluir este evento?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              deleteEvent(id);
              Navigator.of(ctx).pop();
              setState(() {
                _loadEvents();
              });
            },
            child: const Text('Excluir'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}

class EventEditorScreen extends StatefulWidget {
  final DateTime selectedDate;
  final model.Event? event;

  const EventEditorScreen({
    super.key,
    required this.selectedDate,
    this.event,
  });

  @override
  State<EventEditorScreen> createState() => _EventEditorScreenState();
}

class _EventEditorScreenState extends State<EventEditorScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  late DateTime _selectedDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  Color _selectedColor = Colors.teal;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    
    if (widget.event != null) {
      _titleController.text = widget.event!.title;
      if (widget.event!.description != null) {
        _descriptionController.text = widget.event!.description!;
      }
      _selectedDate = widget.event!.date;
      
      if (widget.event!.startTime != null) {
        _startTime = convertToMaterialTimeOfDay(widget.event!.startTime!);
      }
      
      if (widget.event!.endTime != null) {
        _endTime = convertToMaterialTimeOfDay(widget.event!.endTime!);
      }
      
      if (widget.event!.color != null) {
        _selectedColor = convertToMaterialColor(widget.event!.color!);
      }
      
      _isEditing = true;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Evento' : 'Novo Evento'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveEvent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
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
            _buildDatePicker(),
            const SizedBox(height: 16),
            _buildTimePickers(),
            const SizedBox(height: 16),
            _buildColorPicker(),
          ],
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        InkWell(
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: _selectedDate,
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              setState(() {
                _selectedDate = pickedDate;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today),
                const SizedBox(width: 8),
                Text(_formatDate(_selectedDate)),
                const Spacer(),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTimePickers() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Horário',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _startTime ?? TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _startTime = pickedTime;
                      if (_endTime == null) {
                        _endTime = TimeOfDay(
                          hour: (pickedTime.hour + 1) % 24,
                          minute: pickedTime.minute,
                        );
                      }
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(_startTime != null ? _formatTimeOfDay(_startTime!) : 'Início'),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: InkWell(
                onTap: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: _endTime ?? TimeOfDay.now(),
                  );
                  if (pickedTime != null) {
                    setState(() {
                      _endTime = pickedTime;
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.access_time),
                      const SizedBox(width: 8),
                      Text(_endTime != null ? _formatTimeOfDay(_endTime!) : 'Fim'),
                      const Spacer(),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Checkbox(
              value: _startTime == null && _endTime == null,
              onChanged: (value) {
                setState(() {
                  if (value == true) {
                    _startTime = null;
                    _endTime = null;
                  } else {
                    _startTime = TimeOfDay.now();
                    _endTime = TimeOfDay(
                      hour: (TimeOfDay.now().hour + 1) % 24,
                      minute: TimeOfDay.now().minute,
                    );
                  }
                });
              },
            ),
            const Text('Evento de dia inteiro'),
          ],
        ),
      ],
    );
  }

  Widget _buildColorPicker() {
    final colors = [
      Colors.teal,
      Colors.blue,
      Colors.purple,
      Colors.orange,
      Colors.red,
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Cor',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: colors.map((color) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedColor = color;
                });
              },
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _selectedColor == color ? Colors.black : Colors.transparent,
                    width: 2,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  void _saveEvent() {
    final title = _titleController.text.trim();
    final description = _descriptionController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('O título não pode estar vazio')),
      );
      return;
    }

    model.TimeOfDay? startTimeModel;
    model.TimeOfDay? endTimeModel;

    if (_startTime != null) {
      startTimeModel = convertMaterialTimeOfDay(_startTime!);
    }

    if (_endTime != null) {
      endTimeModel = convertMaterialTimeOfDay(_endTime!);
    }

    if (_isEditing) {
      updateEvent(
        widget.event!.id,
        title: title,
        description: description.isEmpty ? null : description,
        date: _selectedDate,
        startTime: startTimeModel,
        endTime: endTimeModel,
        color: convertMaterialColor(_selectedColor),
      );
    } else {
      addEvent(
        title,
        description.isEmpty ? null : description,
        _selectedDate,
        startTimeModel,
        endTimeModel,
        convertMaterialColor(_selectedColor),
      );
    }

    Navigator.of(context).pop(true);
  }
}
