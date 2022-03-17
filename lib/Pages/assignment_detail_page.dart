import 'package:flutter/material.dart';
import 'package:veridox/models/assignment_model.dart';

class AssignmentDetailPage extends StatelessWidget {
  const AssignmentDetailPage({Key? key}) : super(key: key);
  // AssignmentModel sample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assignemnt details page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BasicDetails(
                title: 'Policy Number',
                value: '7583046',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Customer Name',
                value: 'Singh Kumar Rahul',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Applied for Policy',
                value: 'YES',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Application Date',
                value: 'August 11, 2021',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Date and time of field visit',
                value: 'September 06,2021 & 5:00 PM',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Age',
                value: 'NA',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'Received The policy',
                value: 'YES',
              ),
              SizedBox(
                height: 10,
              ),
              BasicDetails(
                title: 'APP NO',
                value: 'A60729340',
              ),
              SizedBox(
                height: 20,
              ),

              //TODO: ADD A PDF BOX
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.40,
                      padding: const EdgeInsets.all(0),
                      // color: Colors.redAccent,
                      child: const SelectableText(
                        'Customer Pdf ',
                        // softWrap: true,
                        // maxLines: 5,
                        // textDirection: TextDirection.rtl,
                        // overflow: TextOverflow.clip,
                        autofocus: false,
                        style: TextStyle(
                          fontSize: 16,
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  // Divider(
                  //   color: Colors.black,
                  //   thickness: 4,
                  // ),
                  const SizedBox(
                    width: 5,
                  ),

                  Expanded(
                    flex: 3,
                    child: Row(
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width * 0.60,
                          alignment: Alignment.center,
                          constraints: const BoxConstraints.tightFor(),
                          padding: const EdgeInsets.all(3),
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: Colors.grey,
                            ),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                            // shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ButtonStyle(
                      // shape: MaterialStateProperty.all(OutlinedBorder.),
                      // side: MaterialStateProperty.all(BorderSide()),
                      elevation: MaterialStateProperty.all(10),
                      minimumSize: MaterialStateProperty.all(Size(150, 40)),
                    ),
                    child: Text(
                      'Verify',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    // );
  }
}

class BasicDetails extends StatelessWidget {
  final String title, value;
  const BasicDetails({
    Key? key,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Container(
            padding: const EdgeInsets.all(0),
            // color: Colors.redAccent,
            child: SelectableText(
              title,
              // softWrap: true,
              // maxLines: 5,
              // textDirection: TextDirection.rtl,
              // overflow: TextOverflow.clip,
              autofocus: false,
              style: TextStyle(
                fontSize: 16,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        // Divider(
        //   color: Colors.black,
        //   thickness: 4,
        // ),
        SizedBox(
          width: 5,
        ),
        Expanded(
          flex: 3,
          child: SelectableText(
            value,
            // softWrap: true,
            // maxLines: 5,
            // textDirection: TextDirection.rtl,
            // overflow: TextOverflow.clip,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        // Container(
        //   padding: const EdgeInsets.all(5),
        //   height: 35,
        //   width: MediaQuery.of(context).size.width - 100 - 60,
        //   color: Colors.green,
        //   child: SingleChildScrollView(
        //     scrollDirection: Axis.horizontal,
        //     child: Text(
        //       'Total family members        Total family members',
        //       style: TextStyle(
        //         fontSize: 18,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
