import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_providers/form_provider.dart';
import '../../app_utils/app_constants.dart';

class DropdownMenu extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final FormProvider provider;
  final String pageId;
  final String fieldId;
  const DropdownMenu({
    Key? key,
    required this.pageId,
    required this.fieldId,
    required this.provider,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late final List<dynamic> items;
  dynamic currentValue;

  @override
  void initState() {
    _initializeOptionList();
    initializeData();
    super.initState();
  }

  void _initializeOptionList() {
    items = [
      {
        'id': '-1',
        'value': 'Choose',
      }
    ];
    if (widget.widgetJson.containsKey('options')) {
      items.addAll(widget.widgetJson['options']);
    }
    currentValue = items[0];
  }

  void initializeData() {
    dynamic init =
        widget.provider.getResult['${widget.pageId},${widget.fieldId}'];
    if (init != null) {
      for (var item in items) {
        if (init['value'] == item['value'] && init['id'] == item['id']) {
          currentValue = item;
        }
      }

      // debugPrint('initial dropdown value --> $init\n');
    }
    // debugPrint('optionList --> $items\n');
  }

  Widget _getLabel() {
    String label = widget.widgetJson['label'];

    return RichText(
      text: TextSpan(
        text: '$label',
        style: const TextStyle(
          fontSize: 17,
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
                fontSize: 18.0,
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getLabel(),
          const SizedBox(
            height: 5,
          ),
          FormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: currentValue,
            validator: (currentOption) {
              if (widget.widgetJson.containsKey('required') &&
                  widget.widgetJson['required'] == true &&
                  currentValue['id'] == '-1') {
                return 'Please choose a option';
              }
              return null;
            },
            builder: (formState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //   color: Colors.grey.shade300,
                      // ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: DropdownButton<dynamic>(
                      isExpanded: true,
                      hint: Text(
                        'Choose',
                        style: kHintTextStyle,
                      ),
                      value: currentValue,
                      icon: const Icon(
                        Icons.arrow_drop_down_outlined,
                        size: 40,
                        color: CupertinoColors.black,
                      ),
                      items: items.map(
                        (option) {
                          var optionMap = option;
                          var value = optionMap['value'];
                          if (value.toString().isEmpty) {
                            value = 'choose';
                          }
                          return DropdownMenuItem(
                            value: option,
                            child: Text(
                              value,
                              style: TextStyle(
                                fontSize: 15,
                                color: optionMap['id'] == '-1'
                                    ? Colors.grey.shade600
                                    : Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(() {
                          currentValue = value;
                        });
                        widget.provider.updateData(
                            pageId: widget.pageId,
                            fieldId: widget.fieldId,
                            value: value);
                        formState.didChange(currentValue);
                      },
                    ),
                  ),
                  if (formState.hasError)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
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
        ],
      ),
    );
  }
}
