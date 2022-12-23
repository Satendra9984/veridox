import 'package:flutter/material.dart';
import 'package:veridox/app_providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:veridox/app_providers/form_provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_screens/on_boarding/on_boarding_screen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // if (Platform.isAndroid) {
  //   await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
  // }
  try {
    // WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User?>(
            create: (context) => FirebaseAuth.instance.authStateChanges(),
            initialData: null),
        ChangeNotifierProvider<SavedAssignmentProvider>(
            create: (context) => SavedAssignmentProvider()),
        ChangeNotifierProvider<CustomAuthProvider>(
            create: (context) => CustomAuthProvider()),
        ChangeNotifierProvider(create: (context) => FormProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Veridox',
        theme: ThemeData(
          // fontFamily: 'Roboto',
          primaryColor: Colors.lightBlue,
          primarySwatch: Colors.blue,
          // textTheme: const TextTheme(),
          fontFamily: 'Ubuntu',
        ),
        // home: FileViewerWidget(),
        routes: {
          '/': (context) => const OnBoardingScreen(),
        },
      ),
    );
  }
}