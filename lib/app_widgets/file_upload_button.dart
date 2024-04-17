import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/uploader.dart';
import 'package:veridox/app_utils/app_constants.dart';

import '../app_screens/pdfviewer.dart';
import '../app_utils/app_functions.dart';

class FileUploadButton extends StatefulWidget {
  final TextEditingController cntrl;
  final Function(String? value) validator;

  const FileUploadButton({
    Key? key,
    required this.text,
    required this.location,
    required this.cntrl,
    required this.validator,
  }) : super(key: key);

  final String text;
  final String location;

  @override
  State<FileUploadButton> createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {
  int progress = 0;
  bool isLoading = false;
  bool isDone = false, showPdfViewer = false;
  String storageRef = '';
  // String fileName = '';

  chooseAndUploadFile() async {
    try {
      final UploadTask? task = await FileUploader.uploadSingleFileToFirebase(
        widget.location,
        fileExtensions: ['pdf'],
      );
      if (task != null) {
        setState(() {
          isDone = false;
          isLoading = true;
        });

        task.snapshotEvents.listen((event) async {
          setState(() {
            progress =
                (event.bytesTransferred / event.totalBytes * 100).floor();

            if (event.state == TaskState.success) {
              setState(() {
                widget.cntrl.text = widget.location;
                isLoading = false;
                // debugPrint('file full path --> $storageRef\n\n');
                isDone = true;
              });
            }
            debugPrint(progress.toString());
          });
          storageRef = await task.snapshot.ref.getDownloadURL();
        });
      } else {
        setState(() {
          isLoading = false;
        });
        // debugPrint('No file selected');
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
      child: FormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: widget.cntrl,
        validator: (controller) {
          return widget.validator(widget.cntrl.text);
        },
        builder: (formState) {
          return Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.lightBlue,
                  backgroundColor: Colors.white,
                  fixedSize: const Size(390, 57),
                  elevation: kElevation,
                  shape: RoundedRectangleBorder(
                    borderRadius: kBorderRadius,
                  ),
                ),
                onPressed: () {
                  /// choosing and uploading file
                  chooseAndUploadFile();
                  formState.didChange(widget.cntrl);
                },
                child: Builder(
                  builder: (context) {
                    if (isDone) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 9,
                            child: Text(
                              '${widget.text} Uploaded',
                              style: const TextStyle(
                                  color: CupertinoColors.activeGreen),
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: GestureDetector(
                              onTap: () async {
                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PdfViewerPage(
                                        storageRef: storageRef,
                                        hintText: widget.text,
                                      );
                                    },
                                  ),
                                ).then((value) {
                                  // debugPrint(
                                  //     'returned to send request screen from pdfviewer page\n\n');
                                });
                              },
                              child: Icon(Icons.visibility),
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              !isLoading
                                  ? Text(
                                      'Upload ${widget.text}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  : Text('Uploading $progress%'),
                              const SizedBox(
                                width: 17,
                              ),
                              !isLoading
                                  ? const Icon(
                                      Icons.upload,
                                      size: 20.0,
                                    )
                                  : const SizedBox(
                                      height: 15,
                                      width: 15,
                                      child: CircularProgressIndicator(
                                          color: Colors.lightBlue),
                                    ),

                              // SfPdfViewer.network(storageRef),
                            ],
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
              if (formState.hasError)
                Padding(
                  padding: const EdgeInsets.only(
                      top: 5, bottom: 5, right: 4, left: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 14,
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
}
