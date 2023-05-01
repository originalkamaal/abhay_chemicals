import 'package:abhay_chemicals/blocs/purchase_bloc/purchase_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/add_new_with_title.dart';
import '../../widgets/list_actions_widget.dart';

class AddPurchase extends StatefulWidget {
  const AddPurchase({super.key});

  @override
  State<AddPurchase> createState() => _AddPurchaseState();
}

class _AddPurchaseState extends State<AddPurchase> {
  // final CollectionReference _purchase =
  //     FirebaseFirestore.instance.collection("purchase");
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PurchaseBloc, PurchaseState>(
      builder: (context, state) {
        if (state is PurchasesLoaded) {
          PurchaseBloc bloc = context.read<PurchaseBloc>();
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
                    rows: state.purchases!.docs.map((e) {
                      return DataRow(cells: [
                        DataCell(Text(e['batchNumber'])),
                        DataCell(Text(e['date'])),
                        DataCell(Text(e['item'])),
                        dataTableActions(context, e.reference),
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
                            dropdownColor:
                                const Color.fromARGB(255, 237, 246, 237),
                            value: selectedCount,
                            items: items.map((e) {
                              return DropdownMenuItem(value: e, child: Text(e));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedCount = value.toString();
                                context.read<PurchaseBloc>().add(
                                    LoadPurchases(limit: int.parse(value!)));
                              });
                            }),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            print("Is first page ${state.pageNumber}");
                            if (state.pageNumber > 1) {
                              bloc.add(LoadPurchases(
                                  direction: "back",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.purchases!.docs.first));
                            }
                          },
                          child: Container(
                            color: const Color.fromARGB(255, 237, 246, 237),
                            padding: const EdgeInsets.all(5),
                            child:
                                const Center(child: Icon(Icons.chevron_left)),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            print("Is first page ${state.pageNumber}");
                            if (state.purchases!.docs.length == state.limit) {
                              bloc.add(LoadPurchases(
                                  direction: "forward",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.purchases!.docs.last));
                              print(state.purchases!.docs.length);
                            }
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 10, right: 20),
                            color: const Color.fromARGB(255, 237, 246, 237),
                            padding: const EdgeInsets.all(5),
                            child:
                                const Center(child: Icon(Icons.chevron_right)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
       