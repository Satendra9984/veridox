import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'package:veridox/form_builder_widgets/date_time_picker.dart';
import 'package:veridox/form_builder_widgets/dropdown_menu.dart';
import 'package:veridox/form_builder_widgets/image_input.dart';
import 'package:veridox/form_builder_widgets/location_input.dart';
import 'package:veridox/form_builder_widgets/single_line_input.dart';
import 'package:veridox/form_builder_widgets/text_display.dart';
import 'package:veridox/form_builder_widgets/multi_line_input.dart';
import 'package:veridox/form_builder_widgets/toggle_button.dart';
import 'package:veridox/form_builder_widgets/table_input.dart';
import '../form_builder_widgets/single_line_row_input.dart';

class FormPage extends StatefulWidget {
  // getting id to save data in the database
  final String formIdInSp;
  final int num;
  final Map<String, dynamic> pageData;
  // {
  //
  //   "page": [
  //     {
  //       "type": "text",
  //       "label": "Death Claim Investigation Report",
  //       "heading_type": 1,
  //     },
  //     {
  //       "type": "text",
  //       "label": "Heading 2",
  //       "heading_type": 2,
  //     },
  //     {
  //       "type": "text",
  //       "label": "Heading 3",
  //       "heading_type": 3,
  //     },
  //     {
  //       "type": "single_line_input",
  //       "label": "Other life/health insurance*",
  //       "value": "",
  //       "input_type": "string/integer/email",
  //       "hint": "yahan likho"
  //     },
  //     {
  //       "type": "single_line_row_input",
  //       "label": "Other life/health insurance*",
  //       "value": "",
  //       "input_type": "string/integer/email",
  //       "hint": "yahan likho"
  //     },
  //     {
  //       "type": "table_input",
  //       "label": "Profile of the life assured*",
  //       "row_labels": [
  //         "Name",
  //         "Date of Birth",
  //         "Age",
  //         "Marital Status",
  //         "Occupation",
  //         "Annual Income",
  //         "Education",
  //         "Other life/health insurance",
  //         "Address",
  //         "Nominee Relationship"
  //       ],
  //       "column_labels": [
  //         "As per investigation",
  //         "Mismatch noted (Yes/No)",
  //         "Evidence procured (Yes/No)"
  //       ],
  //       "value": [
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //         {
  //           "As per investigation": '',
  //           "Mismatch noted (Yes/No)": '',
  //           "Evidence procured (Yes/No)": ''
  //         },
  //       ]
  //     },
  //     {
  //       "type": "multi_line_input",
  //       "label": "Final Remarks*-:",
  //       "value": null,
  //       "input_type": "string",
  //       "hint": "yahan likho"
  //     },
  //     {
  //       "type": "dropdown_menu",
  //       "label": "Select Options",
  //       "value": null,
  //       "options": ['1', '2', '3', '4', '5'],
  //       "hint": "yahan likho"
  //     },
  //     {
  //       "type": "toggle_button",
  //       "label":
  //           "Collect Ration Card / Parivar Card/Voter ID or other possible age proofs of all family members*",
  //       "value": false,
  //       "lines": "multi line",
  //       "heading_type": 1
  //     },
  //     {
  //       "type": "date_time_picker",
  //       "label": "Visited On",
  //       "value": "",
  //     },
  //     {
  //       "type": "location_image",
  //       "value": "firebase_storage_id",
  //     },
  //     {
  //       "type": "image_input",
  //       "value": "firebase_storage_id",
  //     }
  //   ]
  // };
  const FormPage({
    Key? key,
    required this.formIdInSp,
    required this.num,
    required this.pageData,
  }) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  late final List<Map<String, dynamic>> _widgetList;
  late final List<Map<String, dynamic>> _values;
  String _result = '';
  int currentInd = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // index = 0;
    WidgetsBinding.instance!.addObserver(this);
    _widgetList = List<Map<String, dynamic>>.from(widget.pageData["page"]);
    // print(' length---->  ${_widgetList.length}');
    _values = _widgetList;
    // print('_widgetList in formpage--> ${_widgetList}');
  }

  /// Function to update the databases with the updated values
  Future<void> _updateDatabases() async {
    // final fire = await FirebaseFirestore.instance
    //     .collection('assignments')
    //     .doc(widget.formIdInSp)
    //     .get();
    // print('testing onDispose --->  $fire');

    /// TODO: SAVE DATA TO LOCAL_DATABASE
  }

  @override
  void dispose() {
    // Future.delayed(const Duration(seconds: 1), () => _updateDatabases());

    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print('AppLifecycleState.detached');
      // TODO: SAVE THE DATA
    } else if (state == AppLifecycleState.resumed) {
      print('AppLifecycleState.resumed');
    }
  }

  void _onUpdate(int ind, var value) {
    // Todo : Now update data on the _values

    setState(() {
      if (_values[ind].containsKey('value')) {
        _values[ind]['value'] = value;
      }
      _result = _prettyPrint(_values);
      currentInd = ind;
    });
  }

  String _prettyPrint(json) {
    var encoder = const JsonEncoder.withIndent(' ');
    return encoder.convert(json);
  }

  @override
  Widget build(BuildContext context) {
    // print('formpage rebuildeded\n\nn\n');
    super.build(context);
    int index = 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            // height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: Column(
              children: [
                Column(
                  children: _widgetList.map(
                    (widgetData) {
                      final String type = widgetData['type'] ?? '';
                      int i = index;
                      if (index < _widgetList.length - 1) {
                        index++;
                      }
                      // print(i);
                      if (type == 'text') {
                        return TextDisplay(widgetJson: widgetData);
                      } else if (type == 'single_line_input') {
                        return SingleLineInput(
                            onChange: (val) {
                              _onUpdate(i, val);
                            },
                            widgetJson: widgetData);
                      } else if (type == 'single_line_row_input') {
                        return SingleLineRowInput(
                            onChange: (val) {
                              _onUpdate(i, val);
                            },
                            widgetJson: widgetData);
                      } else if (type == 'multi_line_input') {
                        return MultiLineInput(
                          onChange: (val) {
                            _onUpdate(i, val);
                          },
                          widgetJson: widgetData,
                        );
                      } else if (type == 'table_input') {
                        return TableInput(
                          widgetJson: widgetData,
                          onChange: (val) {
                            _onUpdate(i, val);
                          },
                        );
                      } else if (type == 'dropdown_menu') {
                        return DropdownMenu(
                          widgetJson: widgetData,
                          onChange: (val) {
                            _onUpdate(i, val);
                          },
                        );
                      } else if (type == 'toggle_button') {
                        return ToggleButton(
                          widgetJson: widgetData,
                          onChange: (value) => _onUpdate(i, value),
                        );
                      } else if (type == 'date_time_picker') {
                        return DateTimePicker(
                          onChange: (value) => _onUpdate(i, value),
                          widgetjson: widgetData,
                        );
                      } else if (type == 'image_input') {
                        return ImageInput();
                      } else if (type == 'location_image') {
                        return Text('data');
                      }
                      return Text('Something went wrong');
                    },
                  ).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text('index-->  $currentInd \n $_result'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
