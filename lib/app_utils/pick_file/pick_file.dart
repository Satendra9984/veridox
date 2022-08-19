import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';

class PickFile {

  static Future<String?> pickFileAndGetPath() async {
    FilePickerResult? file = await FilePicker.platform.pickFiles();

    if (file != null) {
      debugPrint(file.files.single.path);
      return file.files.single.path;
    }
    return null;
  }

  static Future<List<String?>> pickAndGetFileDirs() async {
    FilePickerResult? files = await FilePicker.platform.pickFiles(
        allowMultiple: true
    );

    if (files != null) {
      return files.files.map((e) => e.path).toList();
    }

    return [];
  }
}

