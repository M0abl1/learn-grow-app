import 'package:flutter/material.dart';
import 'package:learn_grow_app/models/task.dart';

class ProductivityHubScreen extends StatelessWidget {
  const ProductivityHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hub de Produtividade'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ferramentas de Produtividade',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Organize seu tempo e aumente sua produtividade',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24),
            
            // Lista de Tarefas Card
            _buildToolCard(
              context,
              icon: Icons.checklist_rtl,
              title: 'Lista de Tarefas',
              description: 'Organize suas tarefas diárias e acompanhe seu progresso',
              onTap: () {
                Navigator.pushNamed(context, '/tasks');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Calendário Card (implementado)
            _buildToolCard(
              context,
              icon: Icons.calendar_today,
              title: 'Calendário',
              description: 'Visualize e organize seus compromissos',
              onTap: () {
                Navigator.pushNamed(context, '/calendar');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Notas Card (implementado)
            _buildToolCard(
              context,
              icon: Icons.note_alt_outlined,
              title: 'Notas',
              description: 'Capture ideias e informações importantes',
              onTap: () {
                Navigator.pushNamed(context, '/notes');
              },
            ),
            
            const SizedBox(height: 16),
            
            // Pomodoro Card (simulado - não implementado)
            _buildToolCard(
              context,
              icon: Icons.timer_outlined,
              title: 'Pomodoro Timer',
              description: 'Aumente seu foco com a técnica Pomodoro',
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Timer Pomodoro em breve!'))
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildToolCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.teal.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 32,
                  color: Colors.teal.shade700,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
