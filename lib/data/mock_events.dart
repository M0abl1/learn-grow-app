import 'package:learn_grow_app/models/event.dart';
import 'package:flutter/material.dart' as material;

// Lista de eventos mockados para demonstração
final List<Event> mockEvents = [
  Event(
    id: 'e1',
    title: 'Reunião de Equipe',
    description: 'Discussão sobre o progresso do projeto',
    date: DateTime.now(),
    startTime: const TimeOfDay(hour: 10, minute: 0),
    endTime: const TimeOfDay(hour: 11, minute: 30),
    color: Color.teal,
  ),
  Event(
    id: 'e2',
    title: 'Entrega do Projeto',
    description: 'Prazo final para entrega do projeto Flutter',
    date: DateTime.now().add(const Duration(days: 3)),
    startTime: const TimeOfDay(hour: 14, minute: 0),
    endTime: const TimeOfDay(hour: 15, minute: 0),
    color: Color.red,
  ),
  Event(
    id: 'e3',
    title: 'Curso de Flutter',
    description: 'Aula sobre gerenciamento de estado',
    date: DateTime.now().add(const Duration(days: 1)),
    startTime: const TimeOfDay(hour: 19, minute: 0),
    endTime: const TimeOfDay(hour: 21, minute: 0),
    color: Color.blue,
  ),
  Event(
    id: 'e4',
    title: 'Revisão de Código',
    description: 'Revisão do código do aplicativo',
    date: DateTime.now().add(const Duration(days: 2)),
    startTime: const TimeOfDay(hour: 13, minute: 30),
    endTime: const TimeOfDay(hour: 15, minute: 0),
    color: Color.purple,
  ),
];

// Adicionar um novo evento à lista
Event addEvent(String title, String? description, DateTime date, TimeOfDay? startTime, TimeOfDay? endTime, Color? color) {
  final newEvent = Event(
    id: 'e${mockEvents.length + 1}',
    title: title,
    description: description,
    date: date,
    startTime: startTime,
    endTime: endTime,
    color: color ?? Color.teal,
  );
  mockEvents.add(newEvent);
  return newEvent;
}

// Atualizar um evento existente
Event updateEvent(String id, {String? title, String? description, DateTime? date, TimeOfDay? startTime, TimeOfDay? endTime, Color? color}) {
  final index = mockEvents.indexWhere((event) => event.id == id);
  if (index != -1) {
    final updatedEvent = mockEvents[index].copyWith(
      title: title,
      description: description,
      date: date,
      startTime: startTime,
      endTime: endTime,
      color: color,
    );
    mockEvents[index] = updatedEvent;
    return updatedEvent;
  }
  throw Exception('Evento não encontrado');
}

// Excluir um evento
void deleteEvent(String id) {
  mockEvents.removeWhere((event) => event.id == id);
}

// Obter eventos para uma data específica
List<Event> getEventsForDate(DateTime date) {
  return mockEvents.where((event) => 
    event.date.year == date.year && 
    event.date.month == date.month && 
    event.date.day == date.day
  ).toList();
}

// Converter material.TimeOfDay para TimeOfDay do modelo
TimeOfDay convertMaterialTimeOfDay(material.TimeOfDay time) {
  return TimeOfDay(hour: time.hour, minute: time.minute);
}

// Converter TimeOfDay do modelo para material.TimeOfDay
material.TimeOfDay convertToMaterialTimeOfDay(TimeOfDay time) {
  return material.TimeOfDay(hour: time.hour, minute: time.minute);
}

// Converter material.Color para Color do modelo
Color convertMaterialColor(material.Color color) {
  return Color(color.value);
}

// Converter Color do modelo para material.Color
material.Color convertToMaterialColor(Color color) {
  return material.Color(color.value);
}
