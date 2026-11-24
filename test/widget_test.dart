import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:learn_grow_app/main.dart';

void main() {
  setUp(() {
    // Sem rede nos testes: usa as fontes padrão em vez de baixar do Google Fonts.
    GoogleFonts.config.allowRuntimeFetching = false;
    SharedPreferences.setMockInitialValues({});
  });

  testWidgets('abre na splash e segue para a tela de login', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Learn & Grow'), findsWidgets);

    // A splash navega para /auth depois de 3 segundos.
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle();

    expect(find.text('Email'), findsOneWidget);
    expect(find.text('Senha'), findsOneWidget);
  });
}
