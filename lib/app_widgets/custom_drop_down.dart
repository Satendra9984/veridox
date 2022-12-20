import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_utils/app_constants.dart';

class CustomDropDownButton extends StatefulWidget {
  final List<String> list;
  final void Function(int val) onChanged;
  final TextEditingController cntrl;
  final Function(String? value) validator;

  final String hintText;
  const CustomDropDownButton({
    Key? key,
    required this.list,
    required this.onChanged,
    required this.hintText,
    required this.cntrl,
    required this.validator,
  }) : super(key: key);

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  int? dropDown;

  @override
  Widget build(BuildContext context) {
    return FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: widget.cntrl,
        validator: (controller) {
          return widget.validator(widget.cntrl.text);
        },
        builder: (formState) {
          int index = 0;

          return Column(
            children: [
              Card(
                elevation: kElevation,
                shape: RoundedRectangleBorder(
                  borderRadius: kBorderRadius,
                ),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 0),
                  height: 57,
                  child: DropdownButton(
                    style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500),
                    elevation: 0,
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(kBRad),
                    hint: Text(
                      widget.hintText,
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black45,
                          fontWeight: FontWeight.w500),
                    ),
                    underline: Container(),
                    value: dropDown,
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
                        });
                        widget.onChanged(value);
                        formState.didChange(widget.cntrl);
                      }
                    },
                  ),
                ),
              ),
              if (formState.hasError)
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 4, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        });
  }
}
