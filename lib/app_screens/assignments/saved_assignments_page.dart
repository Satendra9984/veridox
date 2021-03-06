import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../app_providers/saved_assignment_provider.dart';
import '../../app_widgets/saved_assignment_card.dart';
import '../../templates/form.dart';

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

    _provider = Provider.of<SavedAssignmentProvider>(context, listen: false);
    Future.delayed(const Duration(seconds: 1), () async {
      await _provider.getLastAssignments();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  /*
  * AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Saved Assignment',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
  * */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text(
          'Saved Assignment',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<SavedAssignmentProvider>(
        builder: (context, data, child) {
          if (data.isLoading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            );
          } else {
            return Column(
              children: [
                ...data.savedAssignments
                    .map(
                      (saveAssignment) => SavedAssignmentCard(
                        navigate: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (ctx) => FormTemplate(
                                saveAssignment: saveAssignment,
                              ),
                            ),
                          );
                        },
                        assignment: saveAssignment,
                      ),
                    )
                    .toList()
              ],
            );
          }
        },
      ),
    );
  }
}
