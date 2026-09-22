// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lab_habitos_sandra_martinez/main.dart';

void main() {
  testWidgets('muestra el estado inicial del panel', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Hábitos | Cumplidos: 0 / 5'), findsOneWidget);
    expect(find.text('¡Empecemos!'), findsOneWidget);
    expect(find.text('Meta: 3 hábitos'), findsOneWidget);
    expect(find.byType(CheckboxListTile), findsNWidgets(5));

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pump();
    expect(find.text('Sin nota'), findsOneWidget);
  });

  testWidgets('actualiza progreso, meta y modo enfoque', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.tap(find.byType(CheckboxListTile).at(1));
    await tester.pump();

    expect(find.text('Hábitos | Cumplidos: 2 / 5'), findsOneWidget);
    expect(find.text('Buen inicio'), findsOneWidget);

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();
    expect(find.byType(CheckboxListTile), findsNWidgets(3));

    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();
    expect(find.byType(CheckboxListTile), findsNWidgets(5));
  });

  testWidgets('guarda una nota y reinicia el día', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Día productivo');
    await tester.tap(find.text('Guardar nota'));
    await tester.pump();
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
    expect(find.text('Día productivo'), findsNWidgets(2));

    await tester.tap(find.byType(CheckboxListTile).first);
    await tester.drag(find.byType(ListView), const Offset(0, -300));
    await tester.pump();
    await tester.tap(find.text('Reiniciar día'));
    await tester.pump();

    await tester.drag(find.byType(ListView), const Offset(0, 1000));
    await tester.pump();
    expect(find.text('Hábitos | Cumplidos: 0 / 5'), findsOneWidget);
    await tester.drag(find.byType(ListView), const Offset(0, -1000));
    await tester.pump();
    expect(find.text('Sin nota'), findsOneWidget);
    expect(find.text('Día productivo'), findsNothing);
  });
}
