import 'package:flutter/material.dart';
import 'package:veridox/app_screens/assignments_home_page.dart';
import 'package:veridox/app_screens/home_page.dart';
import 'package:veridox/app_screens/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:veridox/app_providers/assignment_provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_services/database/firebase_services.dart';
// import 'package:veridox/app_services/database/firestore_services.dart';
import 'app_models/assignment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
            create: (context) => FirebaseAuth.instance.authStateChanges(),
            initialData: null),
        StreamProvider<List<Assignment>>(
            create: (context) => FirestoreServices().getAssignments(),
            initialData: const []),
        ChangeNotifierProvider(create: (context) => AssignmentProvider()),
        ChangeNotifierProvider(create: (context) => SavedAssignmentProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Veridox',
        theme: ThemeData(
          // fontFamily: 'Roboto',
          primaryColor: const Color(0XFFC925E3),
          primarySwatch: Colors.purple,
        ),
        home: const LogInPage(),
        // home: AssignmentsHomePage(),
        // home: SignUp(),
        // home: HomePage(),
        // home: ProfilePage(),

        routes: {
          HomePage.homePageName: (context) => const HomePage(),
          LogInPage.logInPageName: (context) => const LogInPage(),
          AssignmentsHomePage.assignmentsHomePage: (context) =>
              const AssignmentsHomePage(),
        },
      ),
    );
  }
}
