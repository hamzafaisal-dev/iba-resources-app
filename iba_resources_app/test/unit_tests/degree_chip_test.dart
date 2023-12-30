import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/degree_chip.dart';

void main() {
  group("Degree Chip UI Tests", () {
    testWidgets("Renders Chip", (WidgetTester widgetTester) async {
      String label = "BSCS";
      onRemoveCallback() {}

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: DegreeChip(label: label, onRemove: onRemoveCallback),
          ),
        ),
      );

      expect(find.text(label), findsOneWidget);
    });
  });
}
