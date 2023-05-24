import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_providers/form_provider.dart';
import '../app_utils/app_constants.dart';
import '../form_screens/form_constants.dart';

class FormAadharNumberInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  const FormAadharNumberInput({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<FormAadharNumberInput> createState() => _FormAadharNumberInputState();
}

class _FormAadharNumberInputState extends State<FormAadharNumberInput> {
  late TextEditingController _textEditingController;
  bool _isRequired = false;

  @override
  void initState() {
    _textEditingController = TextEditingController();

    String? data =
        widget.provider.getResult['${widget.pageId},${widget.fieldId}'];

    if (data != null) {
      _textEditingController.text = data;
    }
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

  Widget _getLabel() {
    String label = widget.widgetJson['label'];

    return RichText(
      text: TextSpan(
        text: '$label',
        style: const TextStyle(
          fontSize: kLabelFontSize,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        children: [
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true)
            TextSpan(
              text: ' *',
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: kLabelFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _textEditingController,
        validator: (val) {
          String? value = _textEditingController.text;
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true) {
            if (value.isEmpty) return 'This field can\'t be empty';

            bool emailValid =
                RegExp(r'^[2-9]{1}[0-9]{3}[0-9]{4}[0-9]{4}$').hasMatch(value);
            if (!emailValid) return 'Please enter a valid aadhar number';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              _getLabel(),
              const SizedBox(
                height: kTextInputHeightFromLabel,
              ),
              TextField(
                controller: _textEditingController,
                onChanged: (val) {
                  widget.provider.updateData(
                      pageId: widget.pageId,
                      fieldId: widget.fieldId,
                      value: _textEditingController.text);
                  formState.didChange(
                    _textEditingController,
                  );
                },
                minLines: 1,
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  hintText: 'Your Answer',
                  hintStyle: kHintTextStyle,
                  isDense: true, // Added this
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
