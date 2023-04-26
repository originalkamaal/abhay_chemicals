import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddNewWithTitle extends StatelessWidget {
  const AddNewWithTitle({
    super.key,
    required this.title,
    required this.routeName,
  });

  final String title;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 14.sp),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: const Color.fromARGB(255, 34, 78, 12),
          ),
          width: 90,
          height: 30,
          alignment: Alignment.center,
          child: TextButton(
            child: Text(
              "Add New",
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(routeName);
            },
          ),
        ),
      ],
    );
  }
}
