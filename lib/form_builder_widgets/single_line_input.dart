import 'package:flutter/cupertino.dart';

class SingleLineInput extends StatelessWidget {
  // final String value;
  const SingleLineInput({
    Key? key,
    // required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            ' ',
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
          child: Text(''),
        ),
      ],
    );
  }
}
