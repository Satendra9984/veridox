import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SingleLineInput extends StatefulWidget {
  // final String value;
  final Map<String, dynamic> widgetJson;
  final Function(dynamic value) onChange;
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
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '${widget.widgetJson['label']}',
              style: const TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
              softWrap: true,
            ),
            const SizedBox(
              width: 5,
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
                // style: TextStyle(),
                decoration: const InputDecoration(
                  // border: OutlineInputBorder(
                  //   borderRadius: BorderRadius.circular(10),
                  // ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  isDense: true, // Added this
                  contentPadding: EdgeInsets.all(12),
                ),
                // keyboardType: TextInputType.multiline,
                // textInputAction: TextInputAction.newline,
                // minLines: 1,
                // maxLines: null,
                // TODO: VALIDATION
                validator: (val) {
                  return 'error';
                },
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
