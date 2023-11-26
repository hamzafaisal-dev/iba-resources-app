import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.dropDownMenuItems,
      required this.labelText,
      this.width});

  final List<String> dropDownMenuItems;
  final String labelText;
  final double? width;

  final String _selectedValue = '';

  @override
  Widget build(BuildContext context) {
    // if dropdownmenu list empty, return empty dropdwon menu
    if (dropDownMenuItems.isEmpty) {
      return const DropdownMenu(dropdownMenuEntries: []);
    }

    return DropdownMenu(
      //
      width: width,

      initialSelection: dropDownMenuItems[0],

      dropdownMenuEntries: dropDownMenuItems.map(
        (dropdownItem) {
          return DropdownMenuEntry(value: dropdownItem, label: dropdownItem);
        },
      ).toList(),

      onSelected: (value) {
        print(value);
      },

      menuHeight: MediaQuery.of(context).size.height / 4.5,

      label: Text(labelText),

      inputDecorationTheme: const InputDecorationTheme(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
