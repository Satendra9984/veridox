import 'package:flutter/material.dart';

class DetailTextStylesWidget extends StatelessWidget {
  final String heading, value;
  const DetailTextStylesWidget({
    Key? key,
    required this.value,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              heading,
              softWrap: true,
              style: const TextStyle(
                fontSize: 15.0,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              softWrap: true,
              style: const TextStyle(
                fontSize: 15.2,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
