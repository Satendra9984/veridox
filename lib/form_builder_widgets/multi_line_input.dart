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
          height: 2.5,
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0.0, 2.5), //(x,y)
                blurRadius: 3.5,
              ),
            ],
          ),
          child: TextFormField(
            initialValue: widget.widgetJson['value'],
            onChanged: (val) => widget.onChange(val),
            keyboardType: TextInputType.multiline,
            textInputAction: TextInputAction.newline,
            minLines: 3,
            maxLines: null,
            decoration: const InputDecoration(
              //   border: OutlineInputBorder(
              //     borderRadius: BorderRadius.circular(10),
              //   ),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              isDense: true, // Added this
              contentPadding: EdgeInsets.all(10),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
