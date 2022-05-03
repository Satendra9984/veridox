import 'package:flutter/material.dart';

class MultiLineInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final Function(dynamic val) onChange;
  const MultiLineInput({
    Key? key,
    required this.onChange,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<MultiLineInput> createState() => _MultiLineInputState();
}

class _MultiLineInputState extends State<MultiLineInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.widgetJson['label']}',
          softWrap: true,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          onChanged: (val) => widget.onChange(val),
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 3,
          maxLines: null,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
