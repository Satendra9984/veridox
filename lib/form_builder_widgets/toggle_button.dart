import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../app_utils/app_constants.dart';

class ToggleButton extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final Function(dynamic value) onChange;
  const ToggleButton(
      {Key? key, required this.widgetJson, required this.onChange})
      : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    status = widget.widgetJson['value'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: containerElevationDecoration,
          child: Row(
            children: [
              Expanded(
                flex: 8,
                child: Text(
                  widget.widgetJson['label'],
                  style: const TextStyle(fontSize: 15),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                flex: 2,
                child: FlutterSwitch(
                  width: 55.0,
                  height: 30.0,
                  // valueFontSize: 25.0,
                  toggleSize: 25.0,
                  // borderRadius: 30.0,
                  // padding: 3.0,
                  // value: status,
                  value: status,
                  onToggle: (val) {
                    setState(() {
                      status = val;
                    });
                    widget.onChange(val);
                  },
                  activeColor: CupertinoColors.systemGreen,
                  inactiveColor: CupertinoColors.systemRed,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
