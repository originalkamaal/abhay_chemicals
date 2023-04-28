import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/blocs/purchase_bloc/purchase_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/add_new_with_title.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  // final CollectionReference _purchase =
  //     FirebaseFirestore.instance.collection("purchase");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state is PurchaseLoaded) {
          return Container(
            color: Colors.white,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: const AddNewWithTitle(
                      title: "Purchase", routeName: "/addPurchase"),
                ),
                ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: state.purchase
                        .map((e) => Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                color: Colors.green[50],
                                child: Column(
                                  children: [
                                    Text("Created On : ${e.date}"),
                                    Text("Batch No.: ${e.batchNumber}"),
                                  ],
                                ),
                              ),
                            ))
                        .toList())
              ],
            ),
          );
        } else {
          return Text("Error");
        }
      },
    );
  }
  // if (streamSnapshot.hasData) {
  //
  // } else {
  //   return const CircularProgressIndicator();
  // }
}


  //  Flexible(
  //           child: StreamBuilder(
  //             stream: _purchase.snapshots(),
  //             builder: (context, streamSnapshot) {
  //               if (streamSnapshot.hasData) {
  //                 return Container(
  //                   child: ListView.builder(
  //                     itemBuilder: (context, index) {
  //                       final DocumentSnapshot documentSnapshot =
  //                           streamSnapshot.data!.docs[index];

  //                       return Container(
  //                         padding: const EdgeInsets.only(
  //                             left: 20, right: 20, top: 20),
  //                         child: Container(
  //                           padding: EdgeInsets.all(12),
  //                           color: Colors.green[50],
  //                           child: Column(
  //                             children: [
  //                               Text(
  //                                   "Created On : ${documentSnapshot['date']}"),
  //                               Text(
  //                                   "Batch No.: ${documentSnapshot['batchNumber']}"),
  //                             ],
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                     itemCount: streamSnapshot.data!.docs.length,
  //                   ),
  //                 );
  //               } else {
  //                 return const Center(child: Text("Loading"));
  //               }
  //             },
  //           ),
  //         ),
       