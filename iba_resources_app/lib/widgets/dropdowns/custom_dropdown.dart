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

    return Container(
      height: MediaQuery.of(context).size.height / 15,
      width: widget.width,
      child: DropdownButtonFormField(
        //
        items: widget.dropDownMenuItems.map(
          (dropdownItem) {
            return DropdownMenuItem(
                value: dropdownItem, child: Text(dropdownItem));
          },
        ).toList(),

        onChanged: (value) {
          if (value != null) widget.setInput(value);
        },

        validator: (value) {
          if (value == null || value == '') {
            return 'Select at least one value';
          }
          return null;
        },

        decoration: InputDecoration(
          label: Text(widget.labelText),
          hintText: widget.hintText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1.5,
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
      ),
    );
  }
}
