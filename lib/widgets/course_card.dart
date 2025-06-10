import 'package:flutter/material.dart';
import 'package:learn_grow_app/models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  final bool showProgress;

  const CourseCard({
    super.key,
    required this.course,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/course_detail',
          arguments: course.id,
        );
      },
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Placeholder para imagem do curso
              Container(
                height: 120,
                color: Colors.teal.shade200,
                child: Center(
                  child: Icon(
                    Icons.school,
                    size: 48,
                    color: Colors.teal.shade700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categoria do curso
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        course.category,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.teal.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Título do curso
                    Text(
                      course.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Instrutor
                    Text(
                      course.instructor,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    if (showProgress) ...[
                      const SizedBox(height: 8),
                      // Barra de progresso
                      LinearProgressIndicator(
                        value: course.progress,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.teal.shade500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      // Texto de progresso
                      Text(
                        '${(course.progress * 100).toInt()}% concluído',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
