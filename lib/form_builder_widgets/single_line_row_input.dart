import 'package:flutter/material.dart';

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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 5,
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
                height: 40,
                child: VerticalDivider(
                  color: Colors.red,
                  thickness: 2,
                  indent: 5,
                  endIndent: 0,
                  width: 20,
                ),
              ),
              Expanded(
                flex: 5,
                child: TextFormField(
                  initialValue: widget.widgetJson['value'],
                  onChanged: (val) => widget.onChange(val),
                  // style: TextStyle(),
                  decoration: const InputDecoration(
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.only(
                    //     topRight: Radius.circular(7),
                    //     bottomRight: Radius.circular(7),
                    //   ),
                    // ),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    isDense: true, // Added this
                    contentPadding: EdgeInsets.all(13),
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
          height: 30,
        ),
      ],
    );
  }
}
