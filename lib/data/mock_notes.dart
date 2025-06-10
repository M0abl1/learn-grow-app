import 'package:learn_grow_app/models/note.dart';

// Lista de notas mockadas para demonstração
final List<Note> mockNotes = [
  Note(
    id: 'n1',
    title: 'Ideias para projeto final',
    content: 'Implementar autenticação com Firebase\nAdicionar tema escuro\nMelhorar acessibilidade\nAdicionar testes unitários',
    createdAt: DateTime.now().subtract(const Duration(days: 5)),
  ),
  Note(
    id: 'n2',
    title: 'Reunião de equipe',
    content: 'Pontos a discutir:\n- Progresso do sprint atual\n- Impedimentos\n- Planejamento do próximo sprint\n- Feedback dos usuários',
    createdAt: DateTime.now().subtract(const Duration(days: 2)),
    updatedAt: DateTime.now().subtract(const Duration(days: 1)),
  ),
  Note(
    id: 'n3',
    title: 'Lista de livros para ler',
    content: '1. Clean Code - Robert Martin\n2. Flutter in Action\n3. Design Patterns\n4. Refactoring - Martin Fowler',
    createdAt: DateTime.now().subtract(const Duration(days: 10)),
  ),
];

// Adicionar uma nova nota à lista
Note addNote(String title, String content) {
  final newNote = Note(
    id: 'n${mockNotes.length + 1}',
    title: title,
    content: content,
    createdAt: DateTime.now(),
  );
  mockNotes.add(newNote);
  return newNote;
}

// Atualizar uma nota existente
Note updateNote(String id, String title, String content) {
  final index = mockNotes.indexWhere((note) => note.id == id);
  if (index != -1) {
    final updatedNote = mockNotes[index].copyWith(
      title: title,
      content: content,
      updatedAt: DateTime.now(),
    );
    mockNotes[index] = updatedNote;
    return updatedNote;
  }
  throw Exception('Nota não encontrada');
}

// Excluir uma nota
void deleteNote(String id) {
  mockNotes.removeWhere((note) => note.id == id);
}
