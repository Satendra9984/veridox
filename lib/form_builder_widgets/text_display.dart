import 'package:flutter/material.dart';

class TextDisplay extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  const TextDisplay({Key? key, required this.widgetJson}) : super(key: key);

  @override
  State<TextDisplay> createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  // Color _getColour() {}
  double _getFontSize() {
    final size = widget.widgetJson.containsKey('heading_type')
        ? widget.widgetJson['heading_type']
        : -1;
    if (size == 1) {
      return 18;
    } else if (size == 2) {
      return 18;
    } else {
      return 16;
    }
  }

  // FontWeight _getFontWeight() {}
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint(widget.widgetJson.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${widget.widgetJson['label']}',
          style: TextStyle(
            fontSize: _getFontSize(),
            color: Colors.black,
            // fontWeight: FontWeight.bold,
          ),
          softWrap: true,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
