import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigatePush(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigatePushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigatePushReplacementNamed(BuildContext context, String routeName) {
  Navigator.of(context).pushReplacementNamed(routeName);
}

navigatePop(
  BuildContext context,
) {
  Navigator.pop(context);
}

Color getStatusColour(String status) {
  if (status == 'pending') {
    return CupertinoColors.activeBlue;
  } else if (status == 'working') {
    return Colors.orange;
  } else if (status == 'verified') {
    return CupertinoColors.activeGreen;
  } else if (status == 'assigned') {
    return Colors.red;
  }
  return Colors.red;
}
