import 'package:flutter/material.dart';
import 'package:veridox/form_widgets/form_text_input.dart';

import '../app_utils/app_constants.dart';

class FormTableInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  // final Function(dynamic value) onChange;
  const FormTableInput({
    Key? key,
    required this.widgetJson,
    // required this.onChange,
  }) : super(key: key);

  @override
  State<FormTableInput> createState() => _FormTableInputState();
}

class _FormTableInputState extends State<FormTableInput> {
  late List<dynamic> _columnLabels;
  late List<dynamic> _rowLabels;

  @override
  void initState() {
    super.initState();
    _columnLabels = widget.widgetJson['columns'];
    _rowLabels = widget.widgetJson['rows'];
    debugPrint(
        'rows --> ${_rowLabels.toString()}\n and type --> ${_columnLabels.runtimeType}');
    debugPrint('columns --> ${_columnLabels.toString()}');
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// For the main heading/title
          Container(
            margin: const EdgeInsets.only(left: 15, top: 25),
            child: Text(
              widget.widgetJson['label'],
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            /// For each row_label
            children: _rowLabels.map(
              (row) {
                // debugPrint('row --> ${row.toString()}');

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    row != ''
                        ? Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                row['label'].toString(),
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
                          return FormTextInput(
                            widgetData: {
                              "id": col['id'],
                              "label": col['label'],
                              "widget": "text-input"
                            },
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                );
                return Text(row.toString());
              },
            ).toList(),
          ),
        ],
      ),
    );
  }
}
