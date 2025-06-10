import 'package:flutter/material.dart';
import 'package:learn_grow_app/data/mock_data.dart';
import 'package:learn_grow_app/widgets/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Filtrar cursos em andamento (simulado)
    final inProgressCourses = mockCourses.where((course) => course.progress > 0).toList();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learn & Grow'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Implementar notificações
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notificações em breve!'))
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saudação personalizada
              Text(
                'Olá, Usuário!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Pronto para aprender algo novo hoje?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 24),
              
              // Seção de cursos em andamento
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Continue Aprendendo',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/courses');
                    },
                    child: const Text('Ver Todos'),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              
              // Lista de cursos em andamento (ou mensagem se não houver)
              inProgressCourses.isEmpty
                  ? Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.school_outlined,
                              size: 48,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Você ainda não iniciou nenhum curso',
                              style: Theme.of(context).textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/courses');
                              },
                              child: const Text('Explorar Cursos'),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 220,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: inProgressCourses.length,
                        itemBuilder: (ctx, i) => CourseCard(
                          course: inProgressCourses[i],
                          showProgress: true,
                        ),
                      ),
                    ),
              
              const SizedBox(height: 24),
              
              // Seção de cursos recomendados
              Text(
                'Cursos Recomendados',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: mockCourses.length > 3 ? 3 : mockCourses.length,
                  itemBuilder: (ctx, i) => CourseCard(
                    course: mockCourses[i],
                    showProgress: false,
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Seção de produtividade
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.checklist_rtl, color: Colors.teal),
                          const SizedBox(width: 8),
                          Text(
                            'Produtividade',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Organize suas tarefas e aumente sua produtividade',
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, '/productivity');
                        },
                        icon: const Icon(Icons.arrow_forward),
                        label: const Text('Acessar Ferramentas'),
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
  }
}
