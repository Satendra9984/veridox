import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerPage extends StatefulWidget {
  final String storageRef, hintText;
  const PdfViewerPage({
    Key? key,
    required this.storageRef,
    required this.hintText,
  }) : super(key: key);

  @override
  State<PdfViewerPage> createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint('pdf path --> ${widget.storageRef}\n');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.hintText),
      ),
      body: SfPdfViewer.network(
        widget.storageRef,
        key: _pdfViewerKey,
        canShowPasswordDialog: true,
        // pageLayoutMode: ,
      ),
    );
  }
}
