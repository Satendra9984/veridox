import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({Key? key}) : super(key: key);

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          // ListTile(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   leading: Text(
          //     '1234567890',
          //     style: TextStyle(fontSize: 20),
          //   ),
          //   trailing: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       FontAwesomeIcons.phone,
          //       color: CupertinoColors.activeGreen,
          //       size: 30,
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 10,
          // ),
          // ListTile(
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   leading: Text(
          //     'kehavnager kalyani west bengal ',
          //     style: TextStyle(fontSize: 18),
          //   ),
          //   trailing: IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       FontAwesomeIcons.mapLocation,
          //       color: Colors.lightBlue,
          //       size: 30,
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFFd9f1ff),
                ),
                onPressed: () {},
                child: Container(
                  margin: const EdgeInsets.all(15),
                  // padding: EdgeInsets.all(5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FontAwesomeIcons.locationDot,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Find place',
                        style: TextStyle(),
                        textAlign: TextAlign.center,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  shape: const CircleBorder(),
                  backgroundColor: const Color(0xFFE9FCE9),
                ),
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      Icon(
                        FontAwesomeIcons.phone,
                        color: CupertinoColors.activeGreen,
                        size: 30,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Call',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
