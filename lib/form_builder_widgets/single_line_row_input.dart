import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleLineRowInput extends StatefulWidget {
  // final String value;
  final Map<String, dynamic> widgetJson;
  final Function(dynamic value) onChange;
  const SingleLineRowInput({
    Key? key,
    required this.onChange,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<SingleLineRowInput> createState() => _SingleLineRowInputState();
}

class _SingleLineRowInputState extends State<SingleLineRowInput> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          // padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    '${widget.widgetJson['label']}',
                    style: const TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    ),
                    softWrap: true,
                  ),
                ),
              ),
              const SizedBox(
                width: 5,
                height: 5,
              ),
              Expanded(
                flex: 5,
                child: TextFormField(
                  initialValue: widget.widgetJson['value'],
                  onChanged: (val) => widget.onChange(val),
                  // style: TextStyle(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  // keyboardType: TextInputType.multiline,
                  // textInputAction: TextInputAction.newline,
                  // minLines: 1,
                  // maxLines: null,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
