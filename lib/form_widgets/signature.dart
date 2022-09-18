import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../app_utils/app_constants.dart';
import 'get_signature.dart';

class FormSignature extends StatefulWidget {
  const FormSignature({Key? key}) : super(key: key);

  @override
  State<FormSignature> createState() => _FormSignatureState();
}

class _FormSignatureState extends State<FormSignature> {
  Uint8List? _signatureImage;

  Future<void> _getImageFromGallery(FormFieldState formState) async {
    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _signatureImage = await image.readAsBytes();
      // setState(() {
      //   _signatureImage;
      formState.didChange(_signatureImage);
      // });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(5.0),
      decoration: containerElevationDecoration,
      child: FormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          initialValue: _signatureImage,
          validator: (signature) {
            if (_signatureImage == null) {
              return 'Please add your signature';
            }
            return null;
          },
          builder: (formState) {
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  width: MediaQuery.of(context).size.width - 30,
                  child: _signatureImage != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.memory(
                            _signatureImage!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const Text(''),
                ),
                const Divider(thickness: 1.5),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          // setState(() {
                          _signatureImage = null;
                          formState.didChange(_signatureImage);
                          // });
                        },
                        tooltip: 'Clear',
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: CupertinoColors.destructiveRed,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await Navigator.of(context)
                                  .push(
                                MaterialPageRoute(
                                  builder: (context) => const GetSignature(),
                                ),
                              )
                                  .then((value) {
                                if (value != null) {
                                  // setState(() {
                                  _signatureImage = value;
                                  formState.didChange(_signatureImage);
                                  // });
                                }
                              });
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.pencil,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: () async {
                              await _getImageFromGallery(formState);
                            },
                            icon: const FaIcon(
                              FontAwesomeIcons.image,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
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
          }),
    );
  }
}
