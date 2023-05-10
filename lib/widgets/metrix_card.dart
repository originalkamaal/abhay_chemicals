import 'package:flutter/material.dart';

Container metrixCard(
    {required String title,
    required int mainValue,
    required int comparingValue,
    required String type,
    Color? backgroundColor,
    Widget? icon}) {
  Color color = mainValue > comparingValue
      ? Colors.green
      : mainValue < comparingValue
          ? Colors.red
          : Colors.black;
  return Container(
    margin: const EdgeInsets.only(left: 12, right: 12, top: 12),
    padding: const EdgeInsets.all(12),
    width: double.infinity,
    decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              color: Colors.grey.shade300,
              blurStyle: BlurStyle.outer)
        ],
        color: backgroundColor != null ? backgroundColor : Colors.white,
        borderRadius: BorderRadius.circular(12)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: backgroundColor != null ? Colors.white : Colors.black,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "Rs $mainValue",
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  "${mainValue > comparingValue ? "+" : mainValue < comparingValue ? "-" : ""}${(mainValue / comparingValue) * 100}%",
                  style: TextStyle(color: color, fontSize: 12),
                ),
                const Text(" "),
                Text(
                  "since last ${type}",
                  style: TextStyle(
                      color:
                          backgroundColor != null ? Colors.white : Colors.black,
                      fontSize: 12),
                ),
              ],
            )
          ],
        ),
        icon != null ? icon : Container()
      ],
    ),
  );
}
