import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_utils/app_constants.dart';

class ToggleButton extends StatefulWidget {
  final Map<String, dynamic> widgetJson;

  const ToggleButton({
    Key? key,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool? status;
  int tapped = 0;
  Icon _currentIcon = const Icon(
    Icons.check_box_outline_blank,
    size: 28,
  );

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
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: status,
        validator: (value) {
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true &&
              status == null) {
            return 'Please select a value';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            children: [
              Row(
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
                    child: IconButton(
                      icon: _currentIcon,
                      onPressed: () {
                        _setCheckIcon();
                        formState.didChange(status);
                      },
                    ),
                  ),
                ],
              ),
              if (formState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  void _setCheckIcon() {
    tapped = (++tapped) % 3;
    if (tapped == 0) {
      setState(() {
        status = null;
        _currentIcon = const Icon(
          Icons.check_box_outline_blank,
          size: 28,
        );
      });
    } else if (tapped == 1) {
      setState(() {
        status = true;
        _currentIcon = const Icon(
          FontAwesomeIcons.check,
          color: CupertinoColors.systemGreen,
          size: 28,
        );
      });
    } else {
      setState(() {
        status = false;
        _currentIcon = const Icon(
          FontAwesomeIcons.xmark,
          color: CupertinoColors.destructiveRed,
          size: 28,
        );
      });
    }
    debugPrint('status -->> $status');
  }
}
