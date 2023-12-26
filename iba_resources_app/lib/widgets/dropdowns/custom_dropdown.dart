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
  String? _selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedValue,
      items: widget.dropDownMenuItems.map((dropdownItem) {
        return DropdownMenuItem<String>(
          value: dropdownItem,
          child: Text(dropdownItem),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
        widget.setInput(value!);
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Colors.grey,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color:
                Colors.red, // Change to the color you want for the error border
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.5,
            color: Colors
                .red, // Change to the color you want for the focused error border
          ),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select a value';
        }
        return null; // Return null if the value is valid
      },
    );
  }
}
