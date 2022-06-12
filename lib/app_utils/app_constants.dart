import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum Status {
  assigned,
  working,
  pending,
  completed,
}
enum FilterOptions { oldest, all }

enum ScreenNumber {
  home,
  saved,
  profile,
  completed,
}



BoxDecoration containerElevationDecoration = BoxDecoration(
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
);
// Future<SavedAssignment?> _getAssignment() async {
//   if (await checkSaved()) {
//     /// FETCHING DATA FROM THE LOCAL_STORAGE
//     // await FirebaseFirestore.instance
//     //     .collection('assignments')
//     //     .doc('ISFbwFZ4tQybjvbQw6pV')
//     //     .update({
//     //   "report_data": {
//     //     // "id": "12345ab893adfjADF9aksl",
//     //     "pages": [
//     //       {
//     //         "page": {
//     //           "Policy Number": "7583046",
//     //           "Customer Name": "Subhadeep Chowdhary",
//     //           "Applied for policy": "Yes",
//     //           "Application Date": "01/03/22",
//     //           "Date and time of field visit": "03/01/22 12:00pm",
//     //           "Age": "NA",
//     //           "Application No.": "1234567"
//     //         }
//     //       },
//     //       {
//     //         "page": [
//     //           {
//     //             "type": "text",
//     //             "label": "Death Claim Investigation Report",
//     //             "heading_type": 1
//     //           },
//     //           {"type": "text", "label": "Heading 2", "heading_type": 2},
//     //           {"type": "text", "label": "Heading 3", "heading_type": 3},
//     //           {
//     //             "type": "single_line_input",
//     //             "label": "Other life/health insurance*",
//     //             "value": "",
//     //             "input_type": "string/integer/email",
//     //             "hint": "yahan likho"
//     //           },
//     //           {
//     //             "type": "single_line_row_input",
//     //             "label": "Other life/health insurance*",
//     //             "value": "",
//     //             "input_type": "string/integer/email",
//     //             "hint": "yahan likho"
//     //           },
//     //           {
//     //             "type": "table_input",
//     //             "label": "Profile of the life assured*",
//     //             "row_labels": [
//     //               "Name",
//     //               "Date of Birth",
//     //               "Age",
//     //               "Marital Status",
//     //               "Occupation",
//     //               "Annual Income",
//     //               "Education",
//     //               "Other life/health insurance",
//     //               "Address",
//     //               "Nominee Relationship"
//     //             ],
//     //             "column_labels": [
//     //               "As per investigation",
//     //               "Mismatch noted (Yes/No)",
//     //               "Evidence procured (Yes/No)"
//     //             ],
//     //             "value": [
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               },
//     //               {
//     //                 "As per investigation": "",
//     //                 "Mismatch noted (Yes/No)": "",
//     //                 "Evidence procured (Yes/No)": ""
//     //               }
//     //             ]
//     //           },
//     //           {
//     //             "type": "multi_line_input",
//     //             "label": "Final Remarks*-:",
//     //             "value": null,
//     //             "input_type": "string",
//     //             "hint": "yahan likho"
//     //           },
//     //           {
//     //             "type": "dropdown_menu",
//     //             "label": "Select Options",
//     //             "value": null,
//     //             "options": ["1", "2", "3", "4", "5"],
//     //             "hint": "yahan likho"
//     //           },
//     //           {
//     //             "type": "toggle_button",
//     //             "label":
//     //                 "Collect Ration Card / Parivar Card/Voter ID or other possible age proofs of all family members*",
//     //             "value": false,
//     //             "lines": "multi line",
//     //             "heading_type": 1
//     //           },
//     //           {
//     //             "type": "date_time_picker",
//     //             "label": "Visited On",
//     //             "value": ""
//     //           },
//     //           {"type": "location_image", "value": "firebase_storage_id"},
//     //           {"type": "image_input", "value": "firebase_storage_id"}
//     //         ]
//     //       },
//     //       {"page": []},
//     //       {"page": []}
//     //     ]
//     //   }
//     // });
//     try {
//       final mappedData = await SPServices().getSavedAssignment(widget.caseId);
//       final formData = await SPServices().getFormById(widget.caseId);
//
//       print('sp mappedDatatype-->  ${mappedData.runtimeType}');
//
//       final SavedAssignment saveAssignment =
//           SavedAssignment.fromJson(mappedData, formData, widget.caseId);
//       return saveAssignment;
//     } catch (e) {
//       print('hive error--> $e');
//       _showPopUp();
//     }
//   } else {
//     try {
//       /// FETCH DATA FROM THE FIRESTORE
//       final mappedData =
//           await FirestoreServices().getAssignmentById(widget.caseId);
//       // print(mappedData!['report_data']);
//       if (mappedData != null) {
//         // print('mappedData is not null\n\n\n');
//         final formData = mappedData['report_data'];
//         final SavedAssignment savedAssignment =
//             SavedAssignment.fromJson(mappedData, formData, widget.caseId);
//         // print('got saved assignment\n\n\n');
//
//         /// assignment is not saved in local database
//         _isAssignmentSaved = false;
//         return savedAssignment;
//       } else {
//         // print('mappedData is not null\n\n\n');
//         return null;
//       }
//     } catch (e) {
//       // print('firebase error--> $e');
//       _showPopUp();
//     }
//   }
//   return null;
// }
