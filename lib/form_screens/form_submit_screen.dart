import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/form_widgets/location_input.dart';
import 'package:veridox/form_widgets/signature.dart';
import '../app_providers/form_provider.dart';
import '../form_widgets/form_text_input.dart';

class FormSubmitPage extends StatefulWidget {
  final PageController pageController;
  final int currentPage;
  final int totalPages;
  final FormProvider provider;
  const FormSubmitPage({
    Key? key,
    required this.currentPage,
    required this.pageController,
    required this.totalPages,
    required this.provider,
  }) : super(key: key);

  @override
  State<FormSubmitPage> createState() => _FormSubmitPageState();
}

class _FormSubmitPageState extends State<FormSubmitPage>
    with AutomaticKeepAliveClientMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        title: const Text('Submit Form'),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                FormSignature(
                  pageId: widget.currentPage.toString(),
                  fieldId: '0',
                  provider: widget.provider,
                ),
                const SizedBox(
                  height: 10,
                ),
                FormTextInput(
                  widgetJson: {
                    "id": 2,
                    "label": "Final Report",
                    "length": 300,
                    "required": true,
                    "widget": "text-input",
                    "multi_line": true,
                  },
                  pageId: widget.currentPage.toString(),
                  fieldId: '1',
                  provider: widget.provider,
                ),
                GetUserLocation(
                  widgetJson: {
                    'id': 8,
                    'label': 'user location',
                    'widget': 'geolocation',
                    'required': true,
                  },
                  pageId: widget.currentPage.toString(),
                  fieldId: '2',
                  provider: widget.provider,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        widget.pageController
                            .jumpToPage(widget.currentPage - 1);
                      },
                      child: const Center(
                        child: Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () async {
                        await _validateSubmitPage();
                      },
                      child: const Center(
                        child: Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateSubmitPage() async {
    if (_formKey.currentState!.validate()) {
      await showDialog(
          context: context,
          builder: (context) {
            return _showFinalSubmitAlertDialog();
          }).then((submit) {
        if (submit != null && submit == true) {
          FutureProgressDialog(
            _finalSubmitForm(),
            message:
                Text('Submitting Form. Please wait and do not touch anywhere'),
          );
          Navigator.pop(context, true);
        }
      });
    }
  }

  Future<void> _finalSubmitForm() async {
    await widget.provider.saveDraftData().then(
      (value) async {
        // update status
        await FirestoreServices.updateAssignmentStatus(
          caseId: widget.provider.assignmentId,
          status: 'submitted',
          agencyId: widget.provider.agencyId,
        );
      },
    );
  }

  Widget _showFinalSubmitAlertDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Text(
        'Are you sure to submit form? Once submitted you can\'t edit form.Please Re-Check the form.',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            Navigator.pop(context, true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade200,
            elevation: 5,
          ),
          child: Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            // backgroundColor: Colors.redAccent.shade200,
            elevation: 5,
          ),
          child: Text('Cancel'),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
