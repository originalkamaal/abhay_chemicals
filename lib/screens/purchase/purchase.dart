import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/blocs/purchase_bloc/purchase_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    List<String> items = ["10", "20", "30", "50"];
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
                  padding: const EdgeInsets.all(20),
                  child: const AddNewWithTitle(
                      title: "Purchases", routeName: "/addPurchases"),
                ),
                DataTable(
                    columnSpacing: 1,
                    headingRowColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => const Color.fromARGB(255, 237, 246, 237)),
                    columns: const [
                      DataColumn(
                          label: Text(
                        "Batch",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Item",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    ],
                    rows: state.purchase.map((e) {
                      return DataRow(cells: [
                        DataCell(Text(e.batchNumber)),
                        DataCell(Text(e.date)),
                        DataCell(Text(e.item)),
                        DataCell(Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              size: 20,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ],
                        )),
                      ]);
                    }).toList()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: DropdownButton(
                            style:
                                TextStyle(fontSize: 12.sp, color: Colors.black),
                            elevation: 10,
                            dropdownColor:
                                const Color.fromARGB(255, 237, 246, 237),
                            value: "10",
                            items: items
                                .map((e) =>
                                    DropdownMenuItem(value: e, child: Text(e)))
                                .toList(),
                            onChanged: (value) {}),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          color: const Color.fromARGB(255, 237, 246, 237),
                          padding: EdgeInsets.all(5),
                          child: Center(child: Icon(Icons.chevron_left)),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 20),
                          color: const Color.fromARGB(255, 237, 246, 237),
                          padding: EdgeInsets.all(5),
                          child: Center(child: Icon(Icons.chevron_right)),
                        )
                      ],
                    )
                  ],
                )
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
       