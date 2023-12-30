import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/widgets/dividers/named_divider.dart';

void main() {
  group("Auth Provider Button Test", () {
    testWidgets("Renders Auth Provider Button",
        (WidgetTester widgetTester) async {
      String dividerText = "OR";

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NamedDivider(
                dividerText: dividerText, dividerColor: Colors.grey),
          ),
        ),
      );

      expect(find.text(dividerText), findsOneWidget);
    });
  });
}
