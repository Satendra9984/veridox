import 'package:flutter/material.dart';

import '../form_builder_widgets/row_input.dart';

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
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Relationship with LA',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  // textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Customer Representative (if any)',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Contact number of the representative*',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Representative Comments:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
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
              const SizedBox(
                height: 20,
              ),
              RowInputFormField(
                value: 'Name of the person met:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Address of the person met:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Contact number of the person met*:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Residence Status',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RowInputFormField(
                value: 'Type of House:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Location:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Traceability:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Ownership:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Contact Ability',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RowInputFormField(
                value: 'Customer Contacted At Address:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              RowInputFormField(
                value: 'Customer Contacted Over Phone:',
                textFormField: TextFormField(
                  // initialValue: 'satendra pal',
                  textAlign: TextAlign.start,
                  decoration: const InputDecoration(
                    // enabledBorder: OutlineInputBorder(
                    //   borderSide: BorderSide(),
                    //   borderRadius: BorderRadius.circular(10),
                    hintText: 'Enter here',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Final Remarks*-:',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                // initialValue: 'satendra pal',
                textAlign: TextAlign.start,
                maxLines: 7,
                maxLength: 300,
                decoration: const InputDecoration(
                  // enabledBorder: OutlineInputBorder(
                  //   borderSide: BorderSide(),
                  //   borderRadius: BorderRadius.circular(10),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                  ),
                ),
                onChanged: (val) {
                  // FocusScopeNode currentFocus = FocusScope.of(context);
                  // if (!currentFocus.hasPrimaryFocus) {
                  //   currentFocus.unfocus();
                  // }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
