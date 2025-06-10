class Event {
  final String id;
  final String title;
  final String? description;
  final DateTime date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final Color? color;

  Event({
    required this.id,
    required this.title,
    this.description,
    required this.date,
    this.startTime,
    this.endTime,
    this.color,
  });

  Event copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? date,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    Color? color,
  }) {
    return Event(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      color: color ?? this.color,
    );
  }
}

class TimeOfDay {
  final int hour;
  final int minute;

  const TimeOfDay({
    required this.hour,
    required this.minute,
  });

  @override
  String toString() {
    final hourString = hour.toString().padLeft(2, '0');
    final minuteString = minute.toString().padLeft(2, '0');
    return '$hourString:$minuteString';
  }
}

class Color {
  final int value;
  
  const Color(this.value);
  
  static const Color teal = Color(0xFF009688);
  static const Color blue = Color(0xFF2196F3);
  static const Color purple = Color(0xFF9C27B0);
  static const Color orange = Color(0xFFFF9800);
  static const Color red = Color(0xFFF44336);
}
