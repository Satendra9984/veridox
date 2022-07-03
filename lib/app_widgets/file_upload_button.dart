import 'package:flutter/material.dart';
import 'package:veridox/app_utils/app_constants.dart';

class FileUploadButton extends StatefulWidget {
  const FileUploadButton({
    Key? key,
    required this.text,
    required this.onPress,
  }) : super(key: key);
  final String text;
  final Function onPress;
  @override
  State<FileUploadButton> createState() => _FileUploadButtonState();
}

class _FileUploadButtonState extends State<FileUploadButton> {
  bool isUploading = false;
  bool isUploaded = false;
  bool isFailed = false;

  void task() {
    try {
      widget.onPress();
      isUploaded = true;
    } catch (error) {
      isFailed = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: const Color(0XFF0e4a86),
          fixedSize: const Size(390, 57),
          elevation: 0,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0X910e4a86),
              width: 2,
            ),
            borderRadius: kBorderRadius,
          ),
        ),
        onPressed: () {
          setState(() {
            isUploading = true;
          });

          task();
          setState(() {
            isUploading = false;
          });
        },
        child: isUploading
            ? const CircularProgressIndicator(
                color: Color(0XFF0e4a86),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Upload ${widget.text}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  const Icon(
                    Icons.upload,
                    size: 20.0,
                  )
                ],
              ),
      ),
    );
  }
}
