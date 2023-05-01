import 'package:flutter/material.dart';

Future<void> confirmAction(
    {BuildContext? context,
    String? title,
    String? message,
    String? okBtnTitle,
    Function()? onPressed,
    String? cancelBtnTitle}) async {
  return showDialog<void>(
    context: context!,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title ?? "Confirm Delete"),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Text(message ?? "Are You Sure?"),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(okBtnTitle ?? 'Delete'),
            onPressed: () {
              onPressed!();
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(cancelBtnTitle ?? 'Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
