import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleLineInput extends StatefulWidget {
  // final String value;
  final Map<String, dynamic> widgetJson;
  final Function(String val) onChange;
  const SingleLineInput({
    Key? key,
    required this.onChange,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<SingleLineInput> createState() => _SingleLineInputState();
}

class _SingleLineInputState extends State<SingleLineInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            '${widget.widgetJson['label']}',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: TextFormField(
            onChanged: (val) => widget.onChange(val),
          ),
        ),
      ],
    );
  }
}
