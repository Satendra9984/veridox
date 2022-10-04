import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_utils/app_constants.dart';
import '../app_utils/pick_file/pick_file.dart';

class FormFileInput extends StatefulWidget {
  Map<String, dynamic> widgetJson;
  FormFileInput({
    Key? key,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<FormFileInput> createState() => _FormFileInputState();
}

class _FormFileInputState extends State<FormFileInput>
    with AutomaticKeepAliveClientMixin {
  final List<String> _filesList = [];
  bool _canAdd = true;

  int _getCrossAxisCount() {
    Size size = MediaQuery.of(context).size;

    double width = size.width;

    int wid = width.toInt();
    int count = (wid) ~/ 200;
    debugPrint('count --> $count');
    return count;
  }

  String _getLabel() {
    String label = widget.widgetJson['label'];

    if (widget.widgetJson.containsKey('required') &&
        widget.widgetJson['required'] == true) {
      label += '*';
    }
    return label;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _canAdd,
        validator: (fileList) {
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true &&
              _filesList.isEmpty) {
            return 'Please select a file';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getLabel(),
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
              _filesList.isNotEmpty
                  ? GridView.builder(
                      shrinkWrap: true,
                      itemCount: _filesList.length + 1,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: _getCrossAxisCount(),
                        childAspectRatio: 4.7,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 8,
                      ),
                      itemBuilder: (context, index) {
                        if (index <= 2 && index != _filesList.length) {
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.grey.shade400,
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 8,
                                  child: Text(
                                    _filesList[index],
                                    softWrap: false,
                                    // overflow: TextOverflow.visible,
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  height: 10,
                                  color: Colors.black,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: IconButton(
                                      padding:
                                          const EdgeInsets.only(right: 2.5),
                                      onPressed: () {
                                        setState(() {
                                          _filesList.removeAt(index);
                                          _canAdd = true;
                                        });
                                      },
                                      icon: const Icon(Icons.cancel)),
                                ),
                              ],
                            ),
                          );
                        }

                        return const Text('');
                      },
                    )
                  : const Text(''),
              const SizedBox(
                height: 5,
              ),
              if (_canAdd)
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade400,
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade400,
                        offset: const Offset(0.0, 0.5), //(x,y)
                        blurRadius: 1.0,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text(
                            'Add Files',
                            // softWrap: true,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.upload,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                    onTap: () async {
                      PlatformFile? list =
                          await PickFile.pickAndGetFileAsBytes();
                      if (list != null) {
                        debugPrint('file get --> ${list.name}');

                        setState(() {
                          _filesList.add(list.name);
                          debugPrint(_filesList.length.toString());
                        });
                        debugPrint(_filesList.length.toString());

                        if (_filesList.length == 3) {
                          setState(() {
                            _canAdd = false;
                            formState.didChange(_canAdd);
                          });
                        }
                      }
                    },
                  ),
                ),
              if (formState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
