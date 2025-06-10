import 'package:flutter/material.dart';
import 'package:learn_grow_app/data/mock_data.dart';
import 'package:learn_grow_app/widgets/course_card.dart';

class CourseListScreen extends StatefulWidget {
  const CourseListScreen({super.key});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'Todos';
  final List<String> _categories = ['Todos', 'Tecnologia', 'Desenvolvimento Pessoal', 'Negócios'];

  @override
  Widget build(BuildContext context) {
    // Filtrar cursos com base na pesquisa e categoria
    final filteredCourses = mockCourses.where((course) {
      final matchesSearch = course.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          course.description.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'Todos' || course.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cursos'),
      ),
      body: Column(
        children: [
          // Barra de pesquisa
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar cursos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          // Filtro de categorias
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedCategory = category;
                        });
                      }
                    },
                    backgroundColor: Colors.grey.shade200,
                    selectedColor: Colors.teal.shade100,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.teal.shade700 : Colors.black87,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Lista de cursos
          Expanded(
            child: filteredCourses.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum curso encontrado',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredCourses.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/course_detail',
                              arguments: filteredCourses[index].id,
                            );
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Placeholder para imagem do curso
                                Container(
                                  width: 120,
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
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
                                            filteredCourses[index].category,
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
                                          filteredCourses[index].title,
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
                                          filteredCourses[index].instructor,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        // Duração
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: Colors.grey.shade600,
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${filteredCourses[index].durationInMinutes ~/ 60}h ${filteredCourses[index].durationInMinutes % 60}min',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey.shade600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
