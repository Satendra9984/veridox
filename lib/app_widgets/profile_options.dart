import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileOptions extends StatefulWidget {
  final String option;
  final void Function() onPress;
  final Widget valueIcon;
  const ProfileOptions({
    Key? key,
    required this.onPress,
    required this.option,
    required this.valueIcon,
  }) : super(key: key);

  @override
  State<ProfileOptions> createState() => _ProfileOptionsState();
}

class _ProfileOptionsState extends State<ProfileOptions> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: widget.valueIcon,
          ),
          Expanded(
            flex: 6,
            child: Text(
              widget.option,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
              onPressed: widget.onPress,
              splashColor: Colors.red,
              splashRadius: 40,
              icon: const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
