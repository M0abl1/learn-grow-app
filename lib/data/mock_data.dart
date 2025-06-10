import 'package:learn_grow_app/models/course.dart';

final List<Course> mockCourses = [
  Course(
    id: "c1",
    title: "Introdução ao Flutter",
    description: "Aprenda os fundamentos do Flutter e Dart para criar apps incríveis.",
    imageUrl: "assets/images/flutter_intro.png", // Placeholder path
    instructor: "Prof. Augusto",
    modules: ["Introdução", "Widgets Básicos", "Layouts", "Navegação", "Gerenciamento de Estado"],
    category: "Tecnologia",
    durationInMinutes: 360,
  ),
  Course(
    id: "c2",
    title: "Produtividade Pessoal",
    description: "Técnicas e ferramentas para organizar seu tempo e tarefas.",
    imageUrl: "assets/images/productivity.png", // Placeholder path
    instructor: "Coach Ana",
    modules: ["Gestão do Tempo", "Método GTD", "Ferramentas Digitais", "Mindfulness"],
    category: "Desenvolvimento Pessoal",
    durationInMinutes: 180,
  ),
  Course(
    id: "c3",
    title: "Marketing Digital para Iniciantes",
    description: "Entenda os conceitos básicos de marketing online.",
    imageUrl: "assets/images/digital_marketing.png", // Placeholder path
    instructor: "Especialista Bia",
    modules: ["SEO", "Redes Sociais", "Email Marketing", "Analytics"],
    category: "Negócios",
    durationInMinutes: 240,
  ),
  // Adicionar mais cursos mock se necessário para ter variedade
];
