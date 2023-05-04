import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  const ErrorText({
    super.key,
    required this.nameErr,
  });

  final String nameErr;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: nameErr.isNotEmpty,
        child: Container(
          padding: const EdgeInsets.only(top: 10, left: 10),
          child: Text(
            nameErr,
            style: const TextStyle(color: Colors.red),
          ),
        ));
  }
}
