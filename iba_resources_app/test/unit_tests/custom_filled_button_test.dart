import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/widgets/buttons/custom_filled_button.dart';

void main() {
  group("Custom Filled Button Test", () {
    testWidgets("Renders Custom Filled Button",
        (WidgetTester widgetTester) async {
      String buttonLabel = "Button Label";

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: CustomFilledButton(buttonLabel: buttonLabel),
          ),
        ),
      );

      expect(find.text(buttonLabel), findsOneWidget);
    });
  });
}
