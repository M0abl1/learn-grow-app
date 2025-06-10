class Course {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String instructor;
  final List<String> modules;
  final String category;
  final int durationInMinutes;
  final double progress;

  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.instructor,
    required this.modules,
    required this.category,
    required this.durationInMinutes,
    this.progress = 0.0,
  });
}
