import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_utils/app_constants.dart';

class FileInput extends StatefulWidget {
  var widgetJson;
  FileInput({
    Key? key,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<FileInput> createState() => _FileInputState();
}

class _FileInputState extends State<FileInput>
    with AutomaticKeepAliveClientMixin {
  final List<String> _filesList = ['jhanga jjjjjjj', 'managa', 'panga'];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('data'),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: containerElevationDecoration,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.widgetJson['label'],
              softWrap: true,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                // color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: _filesList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.8,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.red,
                      width: 10,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _filesList[index],
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Expanded(
                        child: Icon(Icons.cancel_outlined),
                      ),
                    ],
                  ),
                );
              },
            ),
            Row(
              children: _filesList
                  .map(
                    (e) => Text('data'),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
