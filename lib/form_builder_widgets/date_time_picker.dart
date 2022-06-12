import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker extends StatefulWidget {
  final Map<String, dynamic> widgetjson;
  final void Function(dynamic value) onChange;
  const DateTimePicker({
    Key? key,
    required this.widgetjson,
    required this.onChange,
  }) : super(key: key);

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  // Text
  DateTime _date = DateTime.now();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    try {
      setState(() {
        _date = DateFormat('dd/mm/yyyy').parse(widget.widgetjson['value']);
      });
    } catch (e) {
      _date = DateTime.now();
    }
  }

  void _showDateTimePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    ).then((value) {
      if (value != null) {
        setState(() {
          _date = value;
        });
        String date = _date.day.toString() +
            '/' +
            _date.month.toString() +
            '/' +
            _date.year.toString();
        widget.onChange(date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.widgetjson['label']}',
          style: const TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Container(
          alignment: Alignment.center,
          // height: 40,
          padding: const EdgeInsets.all(0.5),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.shade400,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: const Offset(0.0, 2.5), //(x,y)
                blurRadius: 3.5,
              ),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Expanded(
                flex: 8,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '${_date.day}/${_date.month}/${_date.year}',
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  onPressed: () => _showDateTimePicker(),
                  icon: const Icon(Icons.calendar_today_outlined),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
