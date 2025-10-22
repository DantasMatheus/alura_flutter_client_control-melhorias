import 'package:client_control/models/clients.dart';
import 'package:client_control/models/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:client_control/main.dart' as app;
import 'package:provider/provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('Integration Test', (tester) async {
    final providerKey = GlobalKey();
    app.main(list: [], providerKey: GlobalKey());
    await tester.pumpAndSettle();
    //Testando tela inicial
    expect(find.text('Clientes'), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    //Testando drawer
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();
    expect(find.text('Menu'), findsOneWidget);
    expect(find.text('Gerenciar clientes'), findsOneWidget);
    expect(find.text('Tipos de clientes'), findsOneWidget);
    expect(find.text('Sair'), findsOneWidget);

    //Testar a navegação e a tela de tipos
    await tester.tap(find.text('Tipos de clientes'));
    await tester.pumpAndSettle();
    expect(find.text('Tipos de cliente'), findsOneWidget);
    expect(find.byType(FloatingActionButton), findsOneWidget);
    expect(find.byIcon(Icons.menu), findsOneWidget);
    expect(find.text('Platinum'), findsOneWidget);
    expect(find.text('Golden'), findsOneWidget);
    expect(find.text('Titanium'), findsOneWidget);
    expect(find.text('Diamond'), findsOneWidget);

    // Testar a criação do tipo de cliente
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.enterText(find.byType(TextFormField), 'Ferro');

    await tester.tap(find.text('Sekecionar ícone'));
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.ac_unit).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();
    expect(find.text('Ferro'), findsOneWidget);
    expect(find.byIcon(Icons.ac_unit), findsOneWidget);

    expect(
      Provider.of<Types>(
        providerKey.currentContext!,
        listen: false,
      ).types.last.name,
      'Ferro',
    );
    expect(
      Provider.of<Types>(
        providerKey.currentContext!,
        listen: false,
      ).types.last.icon,
      Icons.ac_unit,
    );

    //Criar um cliente
    await tester.tap(find.byIcon(Icons.menu));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Gerenciar clientes'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    await tester.enterText(find.byKey(Key('nameField')), 'Cliente de Teste');
    await tester.enterText(find.byKey(Key('emailField')), 'client@mail.com');

    await tester.tap(find.byIcon(Icons.arrow_downward));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Ferro').last);
    await tester.pumpAndSettle();

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    //Verificar se o cliente foi criado
    expect(find.text('Cliente de Teste (Ferro)'), findsOneWidget);
    expect(find.byIcon(Icons.ac_unit), findsOneWidget);

    expect(
      Provider.of<Clients>(
        providerKey.currentContext!,
        listen: false,
      ).clients.last.name,
      'Cliente de Teste',
    );
    expect(
      Provider.of<Clients>(
        providerKey.currentContext!,
        listen: false,
      ).clients.last.email,
      'client@mail.com',
    );
  });
}
