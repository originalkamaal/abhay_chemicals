import 'package:abhay_chemicals/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class Customers extends StatelessWidget {
  const Customers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 60,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
