import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

navigatePush(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

navigatePushReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

navigatePushRemoveUntil(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => widget),
      (Route<dynamic> route) => false);
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
  // debugPrint('status --> $status\n\n');
  if (status == 'submitted') {
    return Colors.pinkAccent;
  } else if (status == 'in_progress') {
    return Colors.orange.shade700;
  } else if (status == 'completed') {
    return CupertinoColors.activeGreen;
  } else if (status == 'assigned') {
    return Colors.yellow.shade600;
  } else if (status == 'reassigned') {
    return Colors.red;
  } else if (status == 'approved') {
    return Colors.blueAccent;
  }
  return Colors.redAccent.shade700;
}
