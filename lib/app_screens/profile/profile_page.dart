import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:veridox/app_screens/login/login_page.dart';
import 'package:veridox/app_screens/profile/send_request_screen.dart';
import 'package:veridox/app_screens/profile/update_profile_screen.dart';
import 'package:veridox/app_services/database/firestore_services.dart';
import 'package:veridox/app_services/database/shared_pref_services.dart';
import 'package:veridox/app_utils/app_functions.dart';
import '../../app_services/database/uploader.dart';
import '../../app_utils/pick_file/pick_file.dart';
import '../../app_widgets/profile_options.dart';
import '../assignments/assignment_detail_page.dart';

/// design links
// https://dribbble.com/shots/15978555-qr-details-user-profile/attachments/7815354?mode=media
// https://dribbble.com/shots/17098311/attachments/12190553?mode=media

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  late FirebaseAuth _auth;
  late String _name, _email, _agency_name = '';
  bool _isLoading = false, _loggingOut = false;
  late Uint8List _profilePicture;

  @override
  void initState() {
    _auth = FirebaseAuth.instance;
    super.initState();
  }

  Future<void> _getEmail() async {
    try {
      final snap =
          await FirebaseFirestore.instance.collection('field_verifier').get();

      final user = snap.docs
          .firstWhere((element) => element.id == _auth.currentUser!.uid)
          .data();
      // debugPrint('user data--> ${user}');
      _email = user['email'];
      // debugPrint('email --> ${_email}');
    } catch (e) {
      _email = 'No Registered Email';
    }
  }

  Future<void> _getName() async {
    try {
      final snap =
          await FirebaseFirestore.instance.collection('field_verifier').get();

      final user = snap.docs
          .firstWhere((element) => element.id == _auth.currentUser!.uid)
          .data();

      _name = user['name'];
      // debugPrint('name --> ${_name}');
    } catch (e) {
      _name = 'No Registered User';
      return;
    }
  }

  Future<void> _setDetails() async {
    await _getEmail();
    await _getName();
    await _setProfilePicture();
  }

  Future<void> _uploadProfilePicture() async {
    String userId = _auth.currentUser!.uid;

    await PickFile.pickAndGetFileAsBytes().then(
      (platformFile) async {
        setState(() {
          _isLoading = true;
        });
        if (platformFile != null) {
          /// upload bytes in firebase
          if (platformFile.path != null) {
            File fileImage = File(platformFile.path!);
            Uint8List imageData = await fileImage.readAsBytes();
            // debugPrint('we got imageData\n\n');
            await FileUploader.uploadFile(
                dbPath: '$userId/profile_picture', fileData: imageData);

            // update in field_verifier
            await FirestoreServices.updateDatabase(data: {
              'profile_picture': '$userId/profile_picture',
            }, collection: 'field_verifier', docId: userId);
            await SPServices.setData('$userId/profile_picture', imageData).then(
              (value) async {
                await _setProfilePicture().then((value) {});
              },
            );
          }
        }
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  /// setting the image for display on screen
  Future<void> _setProfilePicture() async {
    String userId = _auth.currentUser!.uid;

    /// setting profile picture from local storage if present
    await SPServices.getData('$userId/profile_picture').then((image) async {
      if (image != null) {
        _profilePicture = image;
      } else {
        ByteData byteData =
            await rootBundle.load('assets/images/doc_image.png');
        _profilePicture = byteData.buffer.asUint8List();
      }
      // debugPrint('profile photo changed -->\n\n');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 15),
          Container(
            alignment: Alignment.topLeft,
            margin:
                const EdgeInsets.only(right: 8.0, left: 15, top: 5, bottom: 0),
            child: Image.asset(
              'assets/launcher_icons/veridocs_launcher_icon.jpeg',
              fit: BoxFit.contain,
              height: 50,
              width: 150,
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
            child: FutureBuilder(
              future: _setDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipOval(
                                      child: Image.memory(
                                        _profilePicture,
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 5,
                                      right: 5,
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.lightBlue,
                                        child: IconButton(
                                          onPressed: () async {
                                            /// upload profile photo
                                            await _uploadProfilePicture()
                                                .then((value) {});
                                          },
                                          icon: Icon(
                                            Icons.add_a_photo,
                                            size: 22,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                          const SizedBox(height: 20),

                          /// name
                          Text(
                            _name,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          const SizedBox(height: 8),

                          /// email
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.email,
                                color: Colors.deepPurpleAccent,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                _email,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          /// phone
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.phone,
                                color: Colors.green,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                FirebaseAuth.instance.currentUser!.phoneNumber
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          /// edit profile button
                          TextButton(
                            onPressed: () {
                              /// navigate to the edit profile screen
                              Navigator.of(context)
                                  .push(CupertinoPageRoute(builder: (context) {
                                return UpdateProfileScreen();
                                // return SendRequestScreen();
                              }));
                            },
                            child: const Text(
                              'Detail',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      _loggingOut
                          ? Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    color: Colors.redAccent,
                                  ),
                                  const SizedBox(width: 25),
                                  Text(
                                    'Logging out',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : ProfileOptions(
                              option: 'Log Out',
                              onPress: () async {
                                setState(() {
                                  _loggingOut = true;
                                });
                                await _auth.signOut().then((value) {
                                  setState(() {
                                    _loggingOut = false;
                                  });
                                  navigatePushRemoveUntil(
                                      context, const LogInPage());
                                });
                              },
                              valueIcon: Icon(
                                Icons.logout,
                                color: Colors.redAccent,
                              ),
                            ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
