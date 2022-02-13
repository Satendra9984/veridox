import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/Pages/assignment_detail_page.dart';
import 'package:veridox/models/assignment_model.dart';

class AssignmentCard extends StatelessWidget {
  const AssignmentCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (ctx) => AssignmentDetailPage()),
        );
      },
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Consumer<AssignmentModel>(
            builder: (BuildContext context, assignment, Widget? child) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/images/doc_image.png',
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 5,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DetailTextStylesWidget(
                            heading: 'CaseId      ',
                            value: assignment.caseId.toString()),
                        DetailTextStylesWidget(
                            heading: 'Description',
                            value: assignment.description.toString()),
                        DetailTextStylesWidget(
                            heading: 'Address    ',
                            value: assignment.address.toString()),
                        DetailTextStylesWidget(
                            heading: 'Type          ',
                            value: assignment.type.toString()),
                        DetailTextStylesWidget(
                            heading: 'CreatedAt',
                            value: assignment.assignedDate.toString()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            child: Text('item1'),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text('item2'),
                            value: 1,
                          ),
                          PopupMenuItem(
                            child: Text('item3'),
                            value: 2,
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DetailTextStylesWidget extends StatelessWidget {
  final String heading, value;
  const DetailTextStylesWidget({
    Key? key,
    required this.value,
    required this.heading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$value                             ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
