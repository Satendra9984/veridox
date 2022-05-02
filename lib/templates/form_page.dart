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
  final Map<String, dynamic> pageData;
  const FormPage(
      {Key? key,
      required this.formIdInSp,
      required this.num,
      required this.pageData})
      : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> with AutomaticKeepAliveClientMixin {
  late final List<Map<String, dynamic>> _widgetList;

  late final List<Map<String, dynamic>> _values;
  late int index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    index = 0;
    _widgetList = widget.pageData['page'];
    _values = _widgetList;
  }

  @override
  void dispose() {
    // TODO: save the form in the database
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
      child: Column(
        children: _widgetList.map(
          (widgetData) {
            final String type = widgetData['type'];
            int i = index++;
            if (type == 'text') {
              return TextDisplay();
            } else if (type == 'single_line_input') {
              return SingleLineInput();
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
