import 'package:flutter/material.dart';
import 'package:veridox/app_utils/app_constants.dart';
import 'package:veridox/form_widgets/table_form_input.dart';

import '../app_providers/form_provider.dart';

class FormTableInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  const FormTableInput({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<FormTableInput> createState() => _FormTableInputState();
}

class _FormTableInputState extends State<FormTableInput> {
  late List<dynamic> _columnLabels;
  late List<dynamic> _rowLabels;
  bool _isRequired = false;

  @override
  void initState() {
    super.initState();
    _columnLabels = widget.widgetJson['columns'];
    _rowLabels = widget.widgetJson['rows'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      _isRequired = true;
    }

    // debugPrint(
    //     'rows --> ${_rowLabels.toString()}\n and type --> ${_columnLabels.runtimeType}');
    // debugPrint('columns --> ${_columnLabels.toString()}');
  }

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(10),
      // ),
      decoration: containerElevationDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// For the main heading/title
          Container(
            margin: const EdgeInsets.only(left: 15, top: 25),
            child: Text(
              _getLabel(),
              style: kFormWidgetLabelStyle,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,

            /// For each row_label
            children: _rowLabels.map(
              (row) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    row != ''
                        ? Column(
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
                          return FormTableTextInput(
                            widgetJson: {
                              "id": col['id'],
                              "label": col['label'],
                              "required": _isRequired,
                              "widget": "text-input"
                            },
                            pageId: widget.pageId,
                            fieldId: widget.fieldId,
                            provider: widget.provider,
                            colId: col['id'].toString(),
                            rowId: row['id'].toString(),
                          );
                        },
                      ).toList(),
                    ),
                    const SizedBox(
                      height: 10,
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
