import 'package:flutter/material.dart';
import 'package:veridox/form_builder_widgets/single_line_row_input.dart';
import 'package:veridox/form_builder_widgets/text_display.dart';

class TableInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final Function(dynamic value) onChange;
  const TableInput({
    Key? key,
    required this.widgetJson,
    required this.onChange,
  }) : super(key: key);

  @override
  State<TableInput> createState() => _TableInputState();
}

class _TableInputState extends State<TableInput> {
  late List<dynamic> _columnLabels;
  late List<dynamic> _rowLabels;
  List<Map<String, dynamic>> dataInput = [];
  @override
  void initState() {
    super.initState();
    _columnLabels = widget.widgetJson['column_labels'];
    _rowLabels = widget.widgetJson['row_labels'];
    dataInput = List<Map<String, dynamic>>.from(widget.widgetJson['value']);
    // print(dataInput);
  }

  void _onUpdate() {
    widget.onChange(dataInput);
    // print(dataInput);
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
      // alignment: Alignment.centerRight,
      child: Column(
        children: [
          Text(
            widget.widgetJson['label'],
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _rowLabels.map(
              (row) {
                int i = index;
                if (index < dataInput.length - 1) {
                  index++;
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    row != ''
                        ? Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                row,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                                softWrap: true,
                              ),
                              const SizedBox(
                                width: 5,
                                height: 0.5,
                              ),
                            ],
                          )
                        : const SizedBox(
                            height: 0,
                          ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _columnLabels.map(
                        (col) {
                          // int i = index;

                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(1.5),
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(5),
                                        child: Text(
                                          col,
                                          style: const TextStyle(
                                            fontSize: 14,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                          softWrap: true,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
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
                                        initialValue: dataInput[i][row],
                                        // initialValue: widget.widgetJson['value'],
                                        onChanged: (val) {
                                          setState(() {
                                            dataInput[i][col] = val;
                                          });
                                          _onUpdate();
                                        },
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
                                          contentPadding: EdgeInsets.all(5),
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
                            ],
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
