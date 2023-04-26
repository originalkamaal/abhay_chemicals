import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddProduction extends StatefulWidget {
  const AddProduction({super.key});

  @override
  State<AddProduction> createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  final CollectionReference _productions =
      FirebaseFirestore.instance.collection("production");
  final CollectionReference _purchases =
      FirebaseFirestore.instance.collection("purchases");

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: const AddNewWithTitle(
                title: "Productions", routeName: "/addProduction"),
          ),
          Flexible(
            child: StreamBuilder(
              stream: _productions.snapshots(),
              builder: (context, streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      final int noOfPalti =
                          documentSnapshot['paltiReport'].length;

                      return Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Container(
                          padding: EdgeInsets.all(12),
                          color: Colors.green[50],
                          child: Column(
                            children: [
                              Text("Created On : ${documentSnapshot['date']}"),
                              Text(
                                  "Batch No.: ${documentSnapshot['batchNumber']}"),
                              FutureBuilder<QuerySnapshot>(
                                  future: FirebaseFirestore.instance
                                      .collection("purchase")
                                      .where("batchNumber",
                                          isEqualTo:
                                              documentSnapshot['batchNumber'])
                                      .get(),
                                  builder: (context, snapShotPurchase) {
                                    if (snapShotPurchase.hasData) {
                                      var docs = snapShotPurchase.data!.docs;
                                      int quantities = 0;
                                      for (var i = 0; i < docs.length; i++) {
                                        quantities = quantities +
                                            (docs[i]['quantity'] as int);
                                      }

                                      return Text(
                                          "Total Quantity : ${quantities.toString()}");
                                    } else {
                                      return const Text("NoData");
                                    }
                                  }),
                              Text(
                                  "Enrichment Date : ${documentSnapshot['enrichment']['date']}"),
                              Text(
                                  "No of Palti : ${documentSnapshot['paltiReport'].length}"),
                              Text(
                                  "Last Palti : ${noOfPalti > 0 ? documentSnapshot['paltiReport'][noOfPalti - 1]['date'] : "NA"}")
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: streamSnapshot.data!.docs.length,
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
  // if (streamSnapshot.hasData) {
  //
  // } else {
  //   return const CircularProgressIndicator();
  // }
}
