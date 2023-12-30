import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:iba_resources_app/widgets/add_resource_all_widgets/selectedFileTile.dart';

void main() {
  group("Selected File Tile Test", () {
    testWidgets("Renders Selected File Tile",
        (WidgetTester widgetTester) async {
      String fileName = "Resource";
      String fileType = "pdf";

      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: FileNameTile(fileName: fileName, fileType: fileType),
          ),
        ),
      );

      expect(find.text(fileName), findsOneWidget);
    });
  });
}
