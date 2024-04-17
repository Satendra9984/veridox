import 'package:flutter/material.dart';

class DetailTextStylesWidget extends StatelessWidget {
  final String heading;
  final Widget? icon;
  final Widget value;
  const DetailTextStylesWidget({
    Key? key,
    required this.value,
    required this.heading,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null)
            Expanded(
              flex: 1,
              child: icon!,
            ),
          Expanded(
            flex: 5,
            child: value,
          ),
        ],
      ),
    );
  }
}
