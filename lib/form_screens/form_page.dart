import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:future_progress_dialog/future_progress_dialog.dart';
import 'package:veridox/app_providers/form_provider.dart';
import 'package:veridox/form_widgets/location_input.dart';
import 'package:veridox/form_widgets/table.dart';
import 'package:veridox/form_widgets/text.dart';
import 'package:veridox/form_widgets/toggle_button.dart';
import '../app_services/database/firestore_services.dart';
import '../app_utils/app_constants.dart';
import '../form_widgets/date_time.dart';
import '../form_widgets/dropdown.dart';
import '../form_widgets/form_aadhar_number_input.dart';
import '../form_widgets/form_email_input.dart';
import '../form_widgets/form_file_input.dart';
import '../form_widgets/form_pan_number_input.dart';
import '../form_widgets/form_text_input.dart';
import '../form_widgets/image_input.dart';
import '../form_widgets/phone_number_input.dart';
import '../form_widgets/signature.dart';

class FormPage extends StatefulWidget {
  final Map<String, dynamic> singlePageData;
  final PageController pageController;
  final int currentPage;
  final int totalPages;
  final FormProvider provider;
  final String agencyId;

  FormPage({
    Key? key,
    required this.currentPage,
    required this.singlePageData,
    required this.pageController,
    required this.totalPages,
    required this.provider,
    required this.agencyId,
  }) : super(key: key);

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();
  late var _pageData;

  late FormProvider provider;

  @override
  void initState() {
    super.initState();
    // debugPrint('form page has been initialized page ${widget.currentPage}');
    provider = widget.provider;
    _initializePageData();
  }

  @override
  void dispose() {
    debugPrint('form page has been disposed page ${widget.currentPage}');
    // widget.provider.dispose();
    super.dispose();
  }

  void _initializePageData() {
    _pageData = widget.singlePageData['fields'] ?? [];
  }

  int _getLength() {
    List<dynamic> wid = _pageData as List<dynamic>;
    return wid.length;
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          Column(
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(5.234589786),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: _getLength(),
                      itemBuilder: (context, index) {
                        var field = _pageData;
                        if (field[index] != null &&
                            field[index]['widget'] == 'text') {
                          return TextTitle(
                            widgetData: field[index],
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'text-input') {
                          return FormTextInput(
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            widgetJson: field[index],
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'address') {
                          return GetUserLocation(
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            widgetJson: field[index],
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'toggle-input') {
                          return ToggleButton(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'dropdown') {
                          return DropdownMenu(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'date-time') {
                          return DateTimePicker(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            // provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'file') {
                          return FormFileInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'image') {
                          return FormImageInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'table') {
                          return FormTableInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'email') {
                          return FormEmailTextInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'phone') {
                          return FormPhoneNumberInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'pan') {
                          return FormPanNumberInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'aadhar') {
                          return FormAadharNumberInput(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else if (field[index] != null &&
                            field[index]['widget'] == 'signature') {
                          return FormSignature(
                            widgetJson: field[index],
                            pageId: widget.currentPage.toString(),
                            fieldId: index.toString(),
                            provider: widget.provider,
                          );
                        } else {
                          return Container(
                            margin: const EdgeInsets.only(top: 15),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            decoration: containerElevationDecoration.copyWith(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  offset: const Offset(0.0, 0.5), //(x,y)
                                  blurRadius: 0.0,
                                ),
                              ],
                            ),
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.error_outline,
                                  color: CupertinoColors.systemRed,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Invalid Form Field',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: CupertinoColors.systemRed,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.currentPage > 0)
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
                        if (widget.currentPage <= widget.totalPages)
                          ElevatedButton(
                            onPressed: () async {
                              await _validateSubmitPage();
                            },
                            child: Center(
                              child: Text(
                                widget.currentPage == widget.totalPages - 1
                                    ? 'Submit'
                                    : 'Next',
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _validateSubmitPage() async {
    if (_formKey.currentState!.validate()) {
      if (widget.currentPage == widget.totalPages - 1) {
        await showDialog(
            context: this.context,
            builder: (context) {
              return _showFinalSubmitAlertDialog();
            }).then(
          (submit) async {
            if (submit != null && submit == true) {
              await showDialog(
                context: context,
                builder: (context) => FutureProgressDialog(
                  _finalSubmitForm(),
                  message: Text(
                    'Submitting Form',
                  ),
                ),
              );
            }
          },
        );
      } else {
        await widget.provider.saveDraftData().then(
          (value) {
            widget.pageController.jumpToPage(widget.currentPage + 1);
          },
        );
      }
    }
  }

  Future<void> _showSubmitted() async {
    await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Future.delayed(
          Duration(seconds: 3),
        ),
        progress: Container(
          child: Icon(
            const IconData(0xf635, fontFamily: 'MaterialIcons'),
            color: CupertinoColors.systemGreen,
            size: 50,
          ),
        ),
        message: Container(
          child: Text(
            'Submitted Successfully',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _showNotSubmitted() async {
    await showDialog(
      context: context,
      builder: (context) => FutureProgressDialog(
        Future.delayed(
          Duration(seconds: 3),
        ),
        progress: Container(
          child: Icon(
            const IconData(0xe6cb, fontFamily: 'MaterialIcons'),
            color: CupertinoColors.systemRed,
            size: 50,
          ),
        ),
        message: Container(
          child: Text(
            'Something Went Wrong',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _finalSubmitForm() async {
    try {
      await widget.provider.saveDraftData().then(
        (value) async {
          await FirestoreServices.updateAssignmentStatus(
            caseId: widget.provider.assignmentId,
            status: 'submitted',
            agencyId: widget.agencyId,
          ).catchError((error) async {
            await _showNotSubmitted();
            return;
          }).then((value) async {
            await _showSubmitted().then((value) {
              Navigator.of(context).pop();
            });
          });
          widget.provider.clearResult();
        },
      );
      return;
    } catch (e) {
      await _showNotSubmitted();
      return;
    }
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
            Navigator.pop(this.context, true);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent.shade200,
            elevation: 5,
          ),
          child: Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(this.context);
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
}
