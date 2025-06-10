import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:learn_grow_app/providers/theme_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar e nome do usuário
              const CircleAvatar(
                radius: 60,
                backgroundColor: Colors.teal,
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Usuário Millennial',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'usuario@exemplo.com',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 32),
              
              // Estatísticas
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estatísticas',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _buildStatItem(
                        context,
                        icon: Icons.school,
                        title: 'Cursos Iniciados',
                        value: '3',
                      ),
                      const Divider(),
                      _buildStatItem(
                        context,
                        icon: Icons.check_circle,
                        title: 'Cursos Concluídos',
                        value: '1',
                      ),
                      const Divider(),
                      _buildStatItem(
                        context,
                        icon: Icons.task_alt,
                        title: 'Tarefas Concluídas',
                        value: '12',
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Configurações
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Configurações',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ListTile(
                        leading: const Icon(Icons.dark_mode),
                        title: const Text('Tema Escuro'),
                        trailing: Switch(
                          value: isDarkMode,
                          onChanged: (value) {
                            themeProvider.toggleTheme(value);
                          },
                          activeColor: Colors.teal,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.notifications),
                        title: const Text('Notificações'),
                        trailing: Switch(
                          value: true, // Valor mockado
                          onChanged: (value) {
                            // Implementação futura
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Configuração de notificações em breve!'))
                            );
                          },
                          activeColor: Colors.teal,
                        ),
                      ),
                      const Divider(),
                      ListTile(
                        leading: const Icon(Icons.language),
                        title: const Text('Idioma'),
                        trailing: const Text('Português'),
                        onTap: () {
                          // Implementação futura
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Configuração de idioma em breve!'))
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Botão de logout
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Navegar para a tela de login
                    Navigator.of(context).pushReplacementNamed('/auth');
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Sair'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Versão do app
              Text(
                'Versão 1.0.0',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildStatItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.teal,
            size: 24,
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
