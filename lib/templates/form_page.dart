import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/form_builder_widgets/date_time_picker.dart';
import 'package:veridox/form_builder_widgets/dropdown_menu.dart';
import 'package:veridox/form_builder_widgets/image_input.dart';
import 'package:veridox/form_builder_widgets/location_input.dart';
import 'package:veridox/form_builder_widgets/single_line_input.dart';
import 'package:veridox/form_builder_widgets/text_display.dart';
import 'package:veridox/form_builder_widgets/multi_line_input.dart';
import 'package:veridox/form_builder_widgets/toggle_button.dart';

class FormPage extends StatefulWidget {
  // getting id to save data in the database
  final String formIdInSp;
  final int num;
  final Map<String, dynamic> pageData = {
    "id": "12345ab893adfjADF9aksl",
    "page": [
      {
        "type": "text",
        "label": "jhanga manga",
        "heading_type": 1,
      },
      {
        "type": "text",
        "label": "jhanga manga",
        "heading_type": 2,
      },
      {
        "type": "text",
        "label": "jhanga manga",
        "heading_type": 3,
      },
      {
        "type": "single_line_input",
        "label": "input le raha",
        "value": null,
        "input_type": "string/integer/email/password",
        "hint": "yahan likho"
      },
      {
        "type": "multi_line_input",
        "label": "input le raha",
        "value": null,
        "input_type": "string",
        "hint": "yahan likho"
      },
      {
        "type": "table",
        "row": 4,
        "column": 5,
        "row_labels": [],
        "column_labels": [],
        "value": [[]]
      },
      {
        "type": "dropdown_menu",
        "label": "jhanga manga",
        "value": null,
        "options": [],
        "hint": "yahan likho"
      },
      {
        "type": "toggle_button",
        "label": "jhanga manga new        \n new line",
        "value": false,
        "lines": "multi line",
        "heading_type": 1
      },
      {"type": "date_time_picker", "value": "28/04/2022"},
      {"type": "location_image", "value": "firebase_storage_id"},
      {"type": "image", "value": "firebase_storage_id"}
    ]
  };
  FormPage({
    Key? key,
    required this.formIdInSp,
    required this.num,
    // required this.pageData
  }) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> with AutomaticKeepAliveClientMixin {
  late final List<Map<String, dynamic>> _widgetList;
  late final List<Map<String, dynamic>> _values;
  String _result = '';
  int currentInd = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // index = 0;
    _widgetList = widget.pageData['page'];
    print(' length---->  ${_widgetList.length}');
    _values = _widgetList;
  }

  void _onUpdate(int ind, var value) {
    // Todo : Now updata data on the _values

    setState(() {
      if (_values[ind].containsKey('value')) {
        _values[ind]['value'] = value;
      }
      _result = _prettyPrint(_values[ind]);
      currentInd = ind;
    });
  }

  String _prettyPrint(json) {
    var encoder = JsonEncoder.withIndent(' ');
    return encoder.convert(json);
  }

  @override
  void dispose() {
    // TODO: save the form in the database
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    int index = 0;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            // decoration: BoxDecoration(
            //   color: Colors.red,
            // ),
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
            child: Column(
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _widgetList.map(
                    (widgetData) {
                      final String type = widgetData['type'];
                      int i = index;
                      if (index < _widgetList.length - 1) {
                        index++;
                      }
                      print(i);
                      if (type == 'text') {
                        return TextDisplay(widgetJson: widgetData);
                      } else if (type == 'single_line_input') {
                        return SingleLineInput(
                          onChange: (val) {
                            // Todo: now value to be added in the _values
                            _onUpdate(i, val);
                          },
                          widgetJson: widgetData,
                        );
                      } else if (type == 'multi_line_input') {
                        return MultiLineInput();
                      } else if (type == 'table') {
                        return Table();
                      } else if (type == 'dropdown_menu') {
                        return DropdownMenu();
                      } else if (type == 'toggle_button') {
                        return ToggleButton();
                      } else if (type == 'date_time_picker') {
                        return DateTimePicker();
                      } else if (type == 'image') {
                        return ImagePicker();
                      } else if (type == 'location_image') {
                        return LocationImage();
                      }
                      return Text('Something went wrong');
                    },
                  ).toList(),
                ),
                SizedBox(
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
