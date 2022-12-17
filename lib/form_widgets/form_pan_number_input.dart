import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_providers/form_provider.dart';
import '../app_utils/app_constants.dart';

class FormPanNumberInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  const FormPanNumberInput({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<FormPanNumberInput> createState() => _FormPanNumberInputState();
}

class _FormPanNumberInputState extends State<FormPanNumberInput> {
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
                RegExp(r"[A-Z]{5}[0-9]{4}[A-Z]{1}").hasMatch(value);
            if (!emailValid) return 'Please enter a valid pan number';
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
              Text(
                _getLabel(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              TextField(
                controller: _textEditingController,
                onChanged: (val) {
                  // _textEditingController.text = val;
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
                  //   border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  //   enabledBorder: InputBorder.none,
                  //   errorBorder: InputBorder.none,
                  //   disabledBorder: InputBorder.none,
                  hintText: 'Your Answer',
                  hintStyle: kHintTextStyle,

                  isDense: true, // Added this
                  // contentPadding: EdgeInsets.all(-10),
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
