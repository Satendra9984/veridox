import 'package:flutter/material.dart';

import '../../Elements/basic_details.dart';

class Page1 extends StatelessWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page 1'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'In case, subscriber is not available, specify details of Third '
                'Party confirmation including spouse/children/relation/neighbor*',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Details obtained from family representative',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RowInputFormField(
                value: 'Customer Representative (if any)',
                textFormField: TextFormField(
                  initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  // decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ),
              ),
              RowInputFormField(
                value: 'Relationship with LA',
                textFormField: TextFormField(
                  initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  // decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ),
              ),
              RowInputFormField(
                value: 'Customer Representative (if any)',
                textFormField: TextFormField(
                  initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  // decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ),
              ),
              RowInputFormField(
                value: 'Contact number of the representative*',
                textFormField: TextFormField(
                  initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  // decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ),
              ),
              RowInputFormField(
                value: 'Representative Comments:',
                textFormField: TextFormField(
                  initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  // decoration: InputDecoration(
                  //   enabledBorder: OutlineInputBorder(
                  //     borderSide: BorderSide(),
                  //     borderRadius: BorderRadius.circular(10),
                  //   ),
                  // ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Details obtained during vicinity check:*',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // RowInputFormField(
              //   value: 'Name of the person met',
              //   field: 'input',
              // ),
              // RowInputFormField(
              //   value: 'Address of the person met',
              //   field: 'input',
              // ),
              // RowInputFormField(
              //   value: 'Contact number of the person met*',
              //   field: 'input',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

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
