import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veridox/form_widgets/get_signature.dart';
import '../app_utils/app_constants.dart';
import '../form_widgets/form_text_input.dart';

class FormSubmitPage extends StatefulWidget {
  final PageController pageController;
  final int currentPage;
  final int totalPages;
  const FormSubmitPage({
    Key? key,
    required this.currentPage,
    required this.pageController,
    required this.totalPages,
  }) : super(key: key);

  @override
  State<FormSubmitPage> createState() => _FormSubmitPageState();
}

class _FormSubmitPageState extends State<FormSubmitPage> {
  Uint8List? _signatureImage;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getImageFromGallery() async {
    // PlatformFile? image =
    //     await PickFile.pickAndGetFileAsBytes(fileExtensions: ['jpg', 'png']);

    var image =
        await ImagePicker.platform.pickImage(source: ImageSource.gallery);

    if (image != null) {
      _signatureImage = await image.readAsBytes();
      setState(() {
        _signatureImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Submit Form'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            // padding: const EdgeInsets.all(5.0),
            decoration: containerElevationDecoration,
            child: Column(
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
                          setState(() {
                            _signatureImage = null;
                          });
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
                                  setState(() {
                                    _signatureImage = value;
                                  });
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
                              await _getImageFromGallery();
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            child: const FormTextInput(
              widgetData: {
                "id": 15,
                "label": "Final Report",
                "length": 300,
                "required": true,
                "widget": "text-input",
                "multi_line": true,
              },
            ),
          ),
          Row(
            children: [
              widget.currentPage > 0
                  ? ElevatedButton(
                      onPressed: () {
                        widget.pageController
                            .jumpToPage(widget.currentPage - 1);
                      },
                      child: const Center(
                        child: Text('Back'),
                      ),
                    )
                  : const Text(''),
              const SizedBox(width: 15),
              widget.currentPage < widget.totalPages - 1
                  ? ElevatedButton(
                      onPressed: () {
                        widget.pageController
                            .jumpToPage(widget.currentPage + 1);
                      },
                      child: const Center(
                        child: Text('Next'),
                      ),
                    )
                  : const Text(''),
            ],
          ),
        ],
      ),
    );
  }
}
