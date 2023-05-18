import 'package:abhay_chemicals/screens/users/careof_screen.dart';
import 'package:abhay_chemicals/screens/users/view_users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("employee")
            .where("email", isEqualTo: FirebaseAuth.instance.currentUser!.email)
            .snapshots(),
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            String role = snapShot.data!.docs[0]['role'];
            if (role == "admin") {
              return DefaultTabController(
                length: 2,
                child: Scaffold(
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
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined)),
                    ],
                    bottom: const TabBar(
                        indicatorColor: Color.fromARGB(255, 34, 78, 12),
                        tabs: [
                          Tab(
                            child: Text(
                              "Admins",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Tab(
                            child: Text(
                              "CareOF",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ]),
                  ),
                  body: const TabBarView(
                    children: [
                      Admin(),
                      CareOf()

                      //Sales
                    ],
                  ),
                ),
              );
            } else {
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
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.search_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications_outlined)),
                    ],
                  ),
                  body: CareOf());
            }
          } else {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Text("Loading.."),
              ),
            );
          }
        });
  }
}
