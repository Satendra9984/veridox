import 'package:flutter/cupertino.dart';

class RowInputFormField extends StatelessWidget {
  final String value;
  final Widget textFormField;
  const RowInputFormField({
    Key? key,
    required this.textFormField,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: textFormField,
        ),
      ],
    );
  }
}
