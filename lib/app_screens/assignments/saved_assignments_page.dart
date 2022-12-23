import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_models/saved_assignment_model.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import '../../app_providers/saved_assignment_provider.dart';
import '../../app_widgets/saved_assignment_card.dart';
import '../../form_screens/home_page.dart';

class SavedAssignmentsPage extends StatefulWidget {
  const SavedAssignmentsPage({Key? key}) : super(key: key);
  @override
  State<SavedAssignmentsPage> createState() => _SavedAssignmentsPageState();
}

class _SavedAssignmentsPageState extends State<SavedAssignmentsPage> {
  late SavedAssignmentProvider _provider;
  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {
    super.dispose();
  }


  Future<List<SavedAssignment>> _setInitialSavedAssignmentsList() async {

    await FirestoreServices.getSavedAssignments().then((list) {
      if(list.isNotEmpty){
        List<SavedAssignment> saveList = list.map((assignment) {
          return SavedAssignment.fromJson(assignment!, assignment['caseId']);
        }).toList();
        return saveList;
      }
      return [];
    });
   return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _setInitialSavedAssignmentsList(),
        builder: (context, AsyncSnapshot<List<SavedAssignment>> form) {
          if (form.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(form.hasError){
            return Center(child: Text('Something Went Wrong'),);
          }else {
            return
          }
        },
      ),
    );
  }
}

/*
SavedAssignmentCard(
                          navigate: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (ctx) {
                                  // debugPrint('Entering from Home page');
                                  return FormHomePage(
                                    caseId: saveAssignment.caseId,
                                  );
                                },
                              ),
                            );
                          },
                          assignment: saveAssignment,
                        ),
* */
