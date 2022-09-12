import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../app_utils/app_constants.dart';


class ToggleButton extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  // final Function(dynamic value) onChange;
  const ToggleButton({
    Key? key,
    required this.widgetJson,
    // required this.onChange,
  }) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool status = false;

  @override
  void initState() {
    super.initState();
  }

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
      debugPrint('$label \n\n');
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Text(
              _getLabel(),
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                // color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            flex: 2,
            child: FlutterSwitch(
              width: 45.0,
              height: 25.0,
              toggleSize: 20.0,
              value: status,
              onToggle: (val) {
                setState(() {
                  status = val;
                });
                // widget.onChange(val);
              },
              activeColor: CupertinoColors.systemGreen,
              inactiveColor: CupertinoColors.systemRed,
            ),
          ),
        ],
      ),
    );
  }
}
