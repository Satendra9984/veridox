import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key}) : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput>
    with AutomaticKeepAliveClientMixin {
  final List<File> _imageFileList = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource imageSource) async {
    if (await Permission.storage.request().isGranted) {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.camera);
      PickedFile recordedImage = PickedFile(image!.path);

      GallerySaver.saveImage(recordedImage.path).then((path) async {
        // setState(() {
        //   firstButtonText = 'image saved!';
        // });
        await _pickImageGall(ImageSource.gallery);
      });
    } else if (await Permission.storage.request().isPermanentlyDenied) {
      await openAppSettings();
    } else if (await Permission.storage.request().isDenied) {
      // setState(() {
      //   permissionGranted = false;
      // });
    }
  }

  Future<void> _pickImageGall(ImageSource imageSource) async {
    final pickedImage = await _picker.pickImage(source: imageSource);
    if (pickedImage != null) {
      setState(() {
        _imageFileList.add(File(pickedImage.path));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
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
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            'data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _imageFileList.length + 1,
            gridDelegate:
                // crossAxisCount stands for number of columns you want for displaying
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
            ),
            itemBuilder: (BuildContext context, int index) {
              // print('index---->  $index');
              // final String im = _imageFileList[index];
              if (index == _imageFileList.length) {
                // print('add button returned');
                return Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(
                              Icons.add_a_photo,
                              size: 40,
                            ),
                            onPressed: () async {
                              await _pickImage(ImageSource.camera);
                            } // size: 50,
                            ),
                      ),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(
                              Icons.image,
                              size: 40,
                            ),
                            onPressed: () async {
                              await _pickImageGall(ImageSource.gallery);
                            }
                            // size: 50,
                            ),
                      ),
                    ],
                  ),
                );
              }
              return Container(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.file(
                    _imageFileList[index],
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
