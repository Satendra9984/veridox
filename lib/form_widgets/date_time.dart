import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_utils/app_constants.dart';

class DateTimePicker extends StatefulWidget {
  final Map<String, dynamic> widgetData;
  // final void Function(dynamic value) onChange;
  const DateTimePicker({
    Key? key,
    required this.widgetData,
    // required this.onChange,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  // Text
  DateTime _date = DateTime.now();
  DateTime _firstDate = DateTime.now();
  DateTime _lastDate = DateTime(2100);

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    try {
      setState(() {
        _date = DateFormat('dd/mm/yyyy').parse(widget.widgetData['value']);
        _firstDate =
            DateFormat('dd/mm/yyyy').parse(widget.widgetData['first-date']);
        _lastDate =
            DateFormat('dd/mm/yyyy').parse(widget.widgetData['last-date']);
      });
    } catch (e) {
      _date = DateTime.now();
    }
  }

  void _showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _firstDate,
      lastDate: _lastDate,
    ).then((value) {
      if (value != null) {
        setState(() {
          _date = value;
        });
        String date = '${_date.day}/${_date.month}/${_date.year}';
        // widget.onChange(date);
      }
    });
  }

  String _getLabel() {
    String label = widget.widgetData['label'];

    if (widget.widgetData.containsKey('required') &&
        widget.widgetData['required'] == true) {
      label += '*';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            _getLabel(),
            style: const TextStyle(
              // fontWeight: FontWeight.bold,
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Text(
                    '${_date.day}/${_date.month}/${_date.year}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => _showDateTimePicker(),
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
