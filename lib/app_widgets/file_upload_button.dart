import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:veridox/app_services/database/uploader.dart';
import 'package:veridox/app_utils/app_constants.dart';

class FileUploadButton extends StatefulWidget {
  const FileUploadButton({Key? key, required this.text, required this.location}) : super(key: key);

  final String text;
  final String location;

  @override
  State<FileUploadButton> createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {

  int progress = 0;
  bool isLoading = false;
  bool isDone = false;
  String storageRef = '';

  chooseAndUploadFile() async {
    try {
      final UploadTask? task = await FileUploader.uploadSingleFileToFirebase(widget.location);
      if (task != null) {
        setState(() {
          isDone = false;
          isLoading = true;
        });

        task.snapshotEvents.listen((event) {
          setState(() {
            progress = (event.bytesTransferred / event.totalBytes * 100).floor();

            if (event.state == TaskState.success) {
              setState(() {
                storageRef = widget.location;
                isLoading = false;
                isDone = true;
              });

            }
            debugPrint(progress.toString());
          });
        });
      } else {
        setState(() {
          isLoading = false;
        });
        debugPrint('No file selected');
      }

    } catch (err) {
      debugPrint(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.lightBlue,
            primary: Colors.white,
            fixedSize: const Size(390, 57),
            elevation: kElevation,
            shape: RoundedRectangleBorder(
              borderRadius: kBorderRadius,
            ),
          ),
        onPressed: () {
            chooseAndUploadFile();
          },
          child: Builder(
            builder: (context) {
              return isDone ? Text('${widget.text} Uploaded', style: const TextStyle(color: CupertinoColors.activeGreen),) : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  !isLoading ? Text('Upload ${widget.text}', style: const TextStyle(fontWeight: FontWeight.w600),) : Text('Uploading $progress%'),
                  const SizedBox(width: 17,),
                  !isLoading ? const Icon(Icons.upload, size: 20.0,)
                        : const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                          color: Colors.lightBlue),
                        )

                ],
              );
            }
          )
      ),
    );
  }
}
