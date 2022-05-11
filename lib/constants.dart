import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

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
