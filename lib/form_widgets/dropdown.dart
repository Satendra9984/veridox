import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_utils/app_constants.dart';

class DropdownMenu extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  // final Function(dynamic val) onChange;
  const DropdownMenu({
    Key? key,
    // required this.onChange,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late final List<dynamic> items;
  dynamic currentValue;

  @override
  void initState() {
    _initializeOptionList();
    super.initState();
  }

  void _initializeOptionList() {
    items = widget.widgetJson['options'] ?? ['choose'];
    currentValue = items[0];
  }

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: DropdownButtonHideUnderline(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _getLabel(),
              softWrap: true,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 2.5),
              decoration: containerElevationDecoration.copyWith(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade500,
                    offset: const Offset(0.0, 0.75), //(x,y)
                    blurRadius: 1.0,
                  ),
                ],
              ),
              child: DropdownButtonFormField<dynamic>(
                hint: const Text(
                  'select options',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                value: currentValue,
                icon: const Icon(
                  Icons.arrow_drop_down,
                  size: 40,
                  color: CupertinoColors.black,
                ),
                items: items.map(
                  (option) {
                    var optionMap = option;
                    var value = optionMap['value'];

                    debugPrint('value data type --> ${value.runtimeType}');
                    if (value.toString().isEmpty) {
                      value = 'choose';
                    }

                    debugPrint(option.toString());
                    return DropdownMenuItem(
                      value: option,
                      onTap: () => setState(() {
                        // if (option['value'] != null ) {
                        // currentValue = option;
                        // }
                        debugPrint('value selected --> $option');
                      }),
                      child: Text(
                        value,
                        style: const TextStyle(fontSize: 14),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (value) => setState(() {
                  // if (value != null) {
                  currentValue = value;
                  // }
                }),
                validator: (curr) {
                  if (curr['value'] == null) {
                    return 'Please select a value';
                  }
                },
                isExpanded: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
