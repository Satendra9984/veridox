import 'package:flutter/material.dart';
import 'package:veridox/app_providers/auth_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:location/location.dart';
import 'package:veridox/app_providers/form_provider.dart';
import 'package:veridox/app_providers/saved_assignment_provider.dart';
import 'package:veridox/app_screens/on_boarding/on_boarding_screen.dart';
import 'package:veridox/app_screens/permissions_page.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart'
    show FirebaseAuthPlatform;

List<CameraDescription> cameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        // home: const Scaffold(
        //   body: GetUserLocation(
        //     widgetJson: {
        //       'label': 'enter location',
        //       "required": true,
        //     },
        //   ),
        // ),
        routes: {
          '/': (context) => const OnBoardingScreen(),
        },
      ),
    );
  }
}

// veridox_githubtoken_2
// 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
// AIzaSyD3A9eyljjrwvGIle9HpKuB63vhLPuixww --> maps api key
// Variant: debugAndroidTest
// Config: debug
// Store: C:\Users\LENOVO\.android\debug.keystore
// Alias: AndroidDebugKey
// MD5: 26:F8:C2:92:1C:1B:99:65:F8:16:60:3A:6F:57:A2:69
// SHA1: 8D:6F:F3:A3:93:F7:AE:7B:9B:5D:53:74:E9:DE:D3:D0:63:21:0A:5F
// SHA-256: 1B:78:FF:B2:81:AD:72:EC:36:CC:6D:5D:AA:AC:A1:25:65:01:6A:6E:B0:10:CE:7B:A1:E0:E7:7C:CB:52:17:52
