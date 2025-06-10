import 'package:flutter/material.dart';
import 'package:learn_grow_app/data/mock_data.dart';
import 'package:learn_grow_app/models/course.dart';

class CourseDetailScreen extends StatelessWidget {
  final String courseId;

  const CourseDetailScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    // Encontrar o curso pelo ID
    final Course selectedCourse = mockCourses.firstWhere((course) => course.id == courseId);
    // final isDarkMode = Theme.of(context).brightness == Brightness.dark; // Variável não utilizada

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCourse.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder para imagem do curso
            Container(
              height: 250,
              width: double.infinity,
              color: Colors.teal.shade200,
              child: Center(
                child: Icon(
                  Icons.school,
                  size: 80,
                  color: Colors.teal.shade700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Título
                  Text(
                    selectedCourse.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Instrutor e Categoria
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        selectedCourse.instructor,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                      const SizedBox(width: 16),
                      Icon(Icons.category_outlined, size: 16, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        selectedCourse.category,
                        style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Descrição
                  Text(
                    'Sobre o Curso',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    selectedCourse.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 24),
                  // Conteúdo do Curso (Módulos)
                  Text(
                    'Conteúdo do Curso',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(), // Disable scrolling within the list
                    itemCount: selectedCourse.modules.length,
                    itemBuilder: (ctx, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.teal.shade100,
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold),
                            ),
                          ),
                          title: Text(selectedCourse.modules[index]),
                          trailing: const Icon(Icons.play_circle_outline),
                          onTap: () {
                            // Navegar para o player do curso (a ser implementado)
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Player para "${selectedCourse.modules[index]}" em breve!'))
                            );
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  // Botão de Ação
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                         ScaffoldMessenger.of(context).showSnackBar(
                           const SnackBar(content: Text('Iniciando curso... (simulado)'))
                         );
                         // Lógica para iniciar/continuar curso
                      },
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Iniciar Curso'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
