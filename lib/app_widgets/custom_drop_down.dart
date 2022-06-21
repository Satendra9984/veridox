import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_services/database/firestore_services.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> list;
  final void Function(int val) onChanged;
  const CustomDropDownButton({
    Key? key,
    required this.list,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  int? dropDown;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Card(
      elevation: 5,
      color: const Color(0xFFf0f5ff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: DropdownButton(
          hint: const Text(
            'select option',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          value: dropDown,
          icon: const Icon(
            Icons.arrow_drop_down,
            size: 40,
            color: CupertinoColors.black,
          ),
          items: widget.list.map((agency) {
            return DropdownMenuItem(
              value: index,
              child: Text(widget.list[index++]),
            );
          }).toList(),
          onChanged: (int? value) {
            // print(value.toString());
            if (value != null) {
              setState(() {
                dropDown = value;
                // print(dropDown.toString());
              });
              widget.onChanged(value);
            }
          },
        ),
      ),
    );
  }
}
// github token --> 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
