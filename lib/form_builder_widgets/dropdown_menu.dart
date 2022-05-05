import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DropdownMenu extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  final Function(dynamic val) onChange;
  const DropdownMenu(
      {Key? key, required this.onChange, required this.widgetJson})
      : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late final List<dynamic> items;
  dynamic currentValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = widget.widgetJson['options'].toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${widget.widgetJson['label']}',
          softWrap: true,
          style: const TextStyle(fontSize: 15),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.grey.shade400,
              width: 1.3,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              hint: const Text(
                'select options',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              value: currentValue,
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: CupertinoColors.black,
              ),
              items: items.map(
                (option) {
                  return DropdownMenuItem(
                    value: option,
                    onTap: () => setState(() {
                      currentValue = option;
                    }),
                    child: Text(
                      option.toString(),
                      style: const TextStyle(fontSize: 14),
                    ),
                  );
                },
              ).toList(),
              onChanged: (val) => setState(() {
                currentValue = val;
                widget.onChange(val);
              }),
              isExpanded: true,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
