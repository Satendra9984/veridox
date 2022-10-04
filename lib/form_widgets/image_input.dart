import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../app_utils/app_constants.dart';
import 'image_upload.dart';

class ImageInput extends StatefulWidget {
  final Map<String, dynamic> widgetJson;
  const ImageInput({
    Key? key,
    required this.widgetJson,
  }) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput>
    with AutomaticKeepAliveClientMixin {
  final List<Uint8List> _imageFileList = [];
  String appBarTitle = " length ";

  Future<void> _addImageToList(List<Uint8List> image) async {
    // int leng = 3 - _imageFileList.length;
    // image.removeRange(leng, image.length);
    int j = 0;
    for (int i = _imageFileList.length; i < 3 && j < image.length; i++) {
      _imageFileList.add(image[j++]);
      // widget.
    }
    setState(() {
      _imageFileList;
    });
  }

  void setAppBarTitle(String path) {
    appBarTitle = _imageFileList.length as String;
  }

  int _getCrossAxisCount() {
    try {
      Size size = MediaQuery.of(context).size;
      // double height = size.height;
      double width = size.width;
      int count = width ~/ 120;
      return count;
    } catch (e) {
      return 4;
    }
    return 4;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
      decoration: containerElevationDecoration,
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _imageFileList,
        validator: (list) {
          if (widget.widgetJson.containsKey('required') &&
              widget.widgetJson['required'] == true &&
              _imageFileList.isEmpty) {
            return 'Please add some images';
          }
          return null;
        },
        builder: (formState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getLabel(),
                softWrap: true,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _imageFileList.length + 1,
                gridDelegate:
                    // crossAxisCount stands for number of columns you want for displaying
                    SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _getCrossAxisCount(),
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  if (index <= 2) {
                    if (index == _imageFileList.length) {
                      /// give option to add images
                      return Container(
                        height: 400,
                        width: 400,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(0.0, 2.5), //(x,y)
                              blurRadius: 3.5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo_outlined,
                                size: 24),
                            onPressed: () async {
                              await Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) {
                                return const ImagePickerImageInput(
                                  title: "Image",
                                );
                              })).then((value) async {
                                if (value != null) {
                                  debugPrint('we got images ${value.length}');
                                  await _addImageToList(value);
                                  formState.didChange(_imageFileList);
                                }
                              });
                              setState(() {
                                appBarTitle = _imageFileList.length.toString();
                              });
                            },
                          ),
                        ),
                      );
                    } else {
                      /// display images
                      return Container(
                        height: 200,
                        width: 200,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey.shade400,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(0.0, 2.5), //(x,y)
                              blurRadius: 3.5,
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.passthrough,
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.memory(
                                _imageFileList[index],
                                fit: BoxFit.contain,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: 0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _imageFileList.removeAt(index);
                                  });
                                  formState.didChange(_imageFileList);
                                },
                                icon: const Icon(
                                  Icons.cancel,
                                  size: 32,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    return const Text('');
                  }
                },
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
