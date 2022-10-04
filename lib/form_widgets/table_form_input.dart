import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_providers/form_provider.dart';
import '../app_utils/app_constants.dart';

class FormTableTextInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  final String colId, rowId;
  const FormTableTextInput({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
    required this.colId,
    required this.rowId,
  }) : super(key: key);

  @override
  State<FormTableTextInput> createState() => _FormTableTextInputState();
}

class _FormTableTextInputState extends State<FormTableTextInput> {
  late final TextEditingController _textEditingController;
  bool _isRequired = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();
    // debugPrint('form text input data --> ${widget.widgetData}');
    super.initState();
  }

  // TextInputType _getKeyboardType() {
  //   if (widget.widgetData['multi_line']) {
  //     return TextInputType.multiline;
  //   } else if (widget.widgetData['type'] == 'number') {
  //     return TextInputType.number;
  //   } else if (widget.widgetData['type'] == 'phone') {
  //     return TextInputType.phone;
  //   } else if (widget.widgetData['type'] == 'email') {
  //     return TextInputType.emailAddress;
  //   }
  //
  //   return TextInputType.text;
  // }

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
      _isRequired = true;
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _textEditingController,
        validator: (val) {
          if (widget.widgetJson['required'] == true &&
              _textEditingController.text.isEmpty) {
            return 'Please enter a value';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getLabel(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _textEditingController,
                onChanged: (text) {
                  widget.provider.updateData(
                    pageId: widget.pageId,
                    fieldId: widget.fieldId,
                    columnId: widget.colId,
                    rowId: widget.rowId,
                    value: _textEditingController.text.toString(),
                  );
                  formState.didChange(_textEditingController);
                },
                minLines: 1,
                maxLines: widget.widgetJson['multi_line'] ?? false ? 7 : 1,
                maxLength: widget.widgetJson['length'],
                // keyboardType: _getKeyboardType(),
                decoration: const InputDecoration(
                  hintText: 'Your Answer',
                  hintStyle: TextStyle(
                    fontSize: 14,
                  ),
                  isDense: true, // Added this
                  // contentPadding: EdgeInsets.all(0),
                ),
              ),
              if (formState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

// if (widget.widgetData['required'] &&
//     (value == null || value.isEmpty)) {
//   return 'Please enter some text';
// }
// if (value != null && value.length > widget.widgetData['length']) {
//   return 'Enter text is exceeding the size';
// }
// if (value != null && widget.widgetData['type'] == 'phone') {
//   bool phone = RegExp(
//           r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
//       .hasMatch(value ?? '');
//   if (!phone) {
//     return 'Please enter a valid phone number';
//   }
// }
// if (value != null &&
//     widget.widgetData['type'] == 'number' &&
//     int.tryParse(value) == null) {
//   return 'Please enter a valid number';
// }
// if (value != null && widget.widgetData['type'] == 'email') {
//   bool email = RegExp(
//           r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
//       .hasMatch(value ?? '');
//   if (!email) {
//     return 'Please enter a valid email';
//   }
// }
// return null;
