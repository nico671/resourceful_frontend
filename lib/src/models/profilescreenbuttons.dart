import 'package:flutter/material.dart';

class ProfileScreenButtons extends StatelessWidget {
  final void Function()? onPressed;
  final String titleText;
  const ProfileScreenButtons({
    required this.onPressed,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all(
              const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  side: BorderSide(width: 2.0, color: Colors.blueGrey)),
            ),
            backgroundColor: MaterialStateProperty.all(Colors.white)),
        onPressed: () async {
          onPressed;
        },
        child: Text(
          titleText,
          style: const TextStyle(color: Colors.blueGrey),
        ));
  }
}
