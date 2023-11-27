import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  const CustomDropdown({
    super.key,
    required this.dropDownMenuItems,
    required this.labelText,
    required this.hintText,
    this.width,
    required this.setInput,
  });

  final List<String> dropDownMenuItems;
  final String labelText;
  final String hintText;
  final double? width;

  final void Function(String dropDownInput) setInput;

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    // if dropdownmenu list empty, return empty dropdwon menu
    if (widget.dropDownMenuItems.isEmpty) {
      return const DropdownMenu(dropdownMenuEntries: []);
    }

    return DropdownMenu(
      //
      width: widget.width,
      hintText: widget.hintText,
      dropdownMenuEntries: widget.dropDownMenuItems.map(
        (dropdownItem) {
          return DropdownMenuEntry(value: dropdownItem, label: dropdownItem);
        },
      ).toList(),

      onSelected: (value) {
        if (value != null) widget.setInput(value);
      },

      menuHeight: MediaQuery.of(context).size.height / 4.5,

      label: Text(widget.labelText),

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

              // DropdownButtonFormField(
              //     items: DropdownItems.resourceTypes
              //         .map((item) => DropdownMenuItem(child: Text(item)))
              //         .toList(),
              //     onChanged: (value) {
              //       print(value);
              //     }),