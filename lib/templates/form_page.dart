// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:veridox/form_builder_widgets/date_time_picker.dart';
// import 'package:veridox/form_builder_widgets/dropdown_menu.dart';
// import 'package:veridox/form_builder_widgets/image_input.dart';
// import 'package:veridox/form_builder_widgets/single_line_input.dart';
// import 'package:veridox/form_builder_widgets/text_display.dart';
// import 'package:veridox/form_builder_widgets/multi_line_input.dart';
// import 'package:veridox/form_builder_widgets/toggle_button.dart';
// import 'package:veridox/form_builder_widgets/table_input.dart';
// import '../form_builder_widgets/single_line_row_input.dart';
//
// class FormPage extends StatefulWidget {
//   /// getting id to save data in the database
//   final String formIdInSp;
//
//   /// page number of the form_page
//   final int num;
//
//   /// json pageData for list getting the list of form element
//   final Map<String, dynamic> pageData;
//
//   const FormPage({
//     Key? key,
//     required this.formIdInSp,
//     required this.num,
//     required this.pageData,
//   }) : super(key: key);
//
//   @override
//   FormState createState() => FormState();
// }
//
// class FormState extends State<FormPage>
//     with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
//   /// List of formDataElements for building the form
//   late final List<Map<String, dynamic>> _widgetList;
//
//   /// List of values for form_elements
//   late final List<Map<String, dynamic>> _values;
//
//   /// just for printing the json_result
//   String _result = '';
//   int currentInd = -1;
//
//   @override
//   void initState() {
//     super.initState();
//
//     /// adding AppStateObserver
//     WidgetsBinding.instance.addObserver(this);
//
//     /// initializing the @_widgetList and @_values
//     _widgetList = List<Map<String, dynamic>>.from(widget.pageData["page"]);
//     _values = _widgetList;
//   }
//
//   /// Function to update the databases with the updated _values
//   Future<void> _updateDatabases() async {}
//
//   @override
//   void dispose() {
//     /// Saving the form_data in local_database and firebase if app is closed
//     Future.delayed(
//       const Duration(seconds: 1),
//       () async => await _updateDatabases().catchError(
//         (error) {
//           return;
//         },
//       ),
//     );
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   /// function to keep track of the AppState
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     super.didChangeAppLifecycleState(state);
//
//     /// when the current screen get_off the focus on phone
//     if (state == AppLifecycleState.paused ||
//         state == AppLifecycleState.detached) {
//       //print('AppLifecycleState.paused')
//       Future.delayed(
//         const Duration(seconds: 1),
//         () async => await _updateDatabases().catchError(
//           (error) {
//             debugPrint('local dba --> $error');
//             return;
//           },
//         ),
//       );
//
//       /// TODO: SAVE THE DATA
//     } else if (state == AppLifecycleState.resumed) {
//       /// when the current screen get_off the focus on phone
//       //print('AppLifecycleState.resumed');
//     }
//   }
//
//   /// Function to update @_values for each element(index) in @_widgetList
//   void _onUpdate(int index, var value) {
//     /// Todo : Now update data on the _values
//
//     setState(() {
//       if (_values[index].containsKey('value')) {
//         _values[index]['value'] = value;
//       }
//       _result = _prettyPrint(_values);
//       currentInd = index;
//     });
//   }
//
//   /// For printing the result in json_format
//   String _prettyPrint(json) {
//     var encoder = const JsonEncoder.withIndent(' ');
//     return encoder.convert(json);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     int index = 0;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: SingleChildScrollView(
//           child: Container(
//             padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
//             child: Column(
//               children: [
//                 Column(
//                   children: _widgetList.map(
//                     (widgetData) {
//                       final String type = widgetData['type'] ?? '';
//                       int i = index;
//                       if (index < _widgetList.length - 1) {
//                         index++;
//                       }
//                       // print(i);
//                       if (type == 'text') {
//                         return TextDisplay(widgetJson: widgetData);
//                       } else if (type == 'single_line_input') {
//                         return SingleLineInput(
//                             onChange: (val) {
//                               _onUpdate(i, val);
//                             },
//                             widgetJson: widgetData);
//                       } else if (type == 'single_line_row_input') {
//                         return SingleLineRowInput(
//                             onChange: (val) {
//                               _onUpdate(i, val);
//                             },
//                             widgetJson: widgetData);
//                       } else if (type == 'multi_line_input') {
//                         return MultiLineInput(
//                           onChange: (val) {
//                             _onUpdate(i, val);
//                           },
//                           widgetJson: widgetData,
//                         );
//                       } else if (type == 'table_input') {
//                         return TableInput(
//                           widgetJson: widgetData,
//                           onChange: (val) {
//                             _onUpdate(i, val);
//                           },
//                         );
//                       } else if (type == 'dropdown_menu') {
//                         return DropdownMenu(
//                           widgetJson: widgetData,
//                           onChange: (val) {
//                             _onUpdate(i, val);
//                           },
//                         );
//                       } else if (type == 'toggle_button') {
//                         return ToggleButton(
//                           widgetJson: widgetData,
//                           onChange: (value) => _onUpdate(i, value),
//                         );
//                       } else if (type == 'date_time_picker') {
//                         return DateTimePicker(
//                           onChange: (value) => _onUpdate(i, value),
//                           widgetjson: widgetData,
//                         );
//                       } else if (type == 'image_input') {
//                         return const ImageInput();
//                       } else if (type == 'location_image') {
//                         return const Text('data');
//                       }
//                       return const Text('Something went wrong');
//                     },
//                   ).toList(),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Center(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       /// SAVE THE PAGE_DATA
//                       await _updateDatabases();
//                     },
//                     child: const Text('Save'),
//                   ),
//                 ),
//                 Text('index-->  $currentInd \n $_result'),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//
//   /// implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
