import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/widgets/home_screen_widgets/filter_chip.dart';

void main() {
  group("Degree Chip UI Tests", () {
    testWidgets("Renders Chip", (WidgetTester widgetTester) async {
      String chipLabel = "Text";
      onPressedCallback(String string) {}

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomFilterChip(
              chipLabel: chipLabel,
              onPressed: onPressedCallback,
            ),
          ),
        ),
      );

      expect(find.text(chipLabel), findsOneWidget);
    });
  });
}
