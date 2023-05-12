import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/controllers/purchase_controller.dart';
import 'package:abhay_chemicals/widgets/add_new_palti.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:abhay_chemicals/widgets/edit_comp_enrich.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/list_actions_widget.dart';

class AddProduction extends StatefulWidget {
  const AddProduction({super.key});

  @override
  State<AddProduction> createState() => _AddProductionState();
}

class _AddProductionState extends State<AddProduction> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  double bottomSheetHeight = 450;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductionBloc, ProductionState>(
      builder: (context, state) {
        ProductionBloc bloc = context.read<ProductionBloc>();
        if (state is ProductionsLoading) {
          return const Center(child: Text("Loading..."));
        } else if (state is ProductionsLoaded) {
          return Container(
            color: Colors.white,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const AddNewWithTitle(
                      title: "Productions", routeName: "/addProductions"),
                ),
                DataTable(
                    showCheckboxColumn: false,
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
                        "Actions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    ],
                    rows: state.productions!.docs.map((e) {
                      return DataRow(
                        cells: [
                          DataCell(Text(e['batchNumber'])),
                          DataCell(Text(e['date'])),
                          dataTableActions(context, e, ""),
                        ],
                        onSelectChanged: (value) {
                          // ignore: use_build_context_synchronously
                          showModalBottomSheet(
                            isScrollControlled: true,
                            useSafeArea: true,
                            enableDrag: false,
                            context: context,
                            backgroundColor:
                                const Color.fromARGB(255, 237, 246, 237),
                            builder: (context) => FutureBuilder(
                                future: PurchaseController()
                                    .getBatchPurchases(e['batchNumber']),
                                builder: (context, docs) {
                                  if (docs.hasData) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.close,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                context
                                                    .read<CommonBloc>()
                                                    .add(OpenBottomSheet(true));
                                              },
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 10),
                                            width: double.maxFinite,
                                            child: Card(
                                              elevation: 5,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: const [
                                                          Text(
                                                              "Batch Number : "),
                                                          Text("Date :"),
                                                          Text("Quantities :"),
                                                        ],
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                              e['batchNumber']),
                                                          Text(e['date']),
                                                          Text(docs.data![
                                                                  'totalQuantities']
                                                              .toString())
                                                        ],
                                                      )
                                                    ]),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                              visible: (docs.data!['docs']
                                                      as QuerySnapshot)
                                                  .docs
                                                  .isNotEmpty,
                                              child: Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 10,
                                                    top: 10),
                                                child: const Text(
                                                  "Raw Materials",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )),
                                          Visibility(
                                            visible: (docs.data!['docs']
                                                    as QuerySnapshot)
                                                .docs
                                                .isNotEmpty,
                                            child: Center(
                                              child: Card(
                                                elevation: 5,
                                                child: DataTable(
                                                    headingRowHeight: 40,
                                                    columns: const [
                                                      DataColumn(
                                                          label: Text("Date")),
                                                      DataColumn(
                                                          label:
                                                              Text("Truck No")),
                                                      DataColumn(
                                                          label:
                                                              Text("Quantity")),
                                                    ],
                                                    rows: (docs.data!['docs']
                                                            as QuerySnapshot)
                                                        .docs
                                                        .map((ed) {
                                                      return DataRow(cells: [
                                                        DataCell(
                                                            Text(ed['date'])),
                                                        DataCell(Text(
                                                            ed['truckNumber']
                                                                .toString())),
                                                        DataCell(Text(
                                                            ed['quantity']
                                                                .toString())),
                                                      ]);
                                                    }).toList()),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 10,
                                                    top: 20),
                                                child: const Text(
                                                  "Composting",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  return await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            content:
                                                                EditCompEnrich(
                                                          e: e,
                                                          edit: true,
                                                        ));
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 34, 78, 12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 5,
                                                      right: 20),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: const Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Center(
                                              child: Card(
                                                elevation: 5,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: DataTable(
                                                      headingRowHeight: 40,
                                                      columns: const [
                                                        DataColumn(
                                                            label:
                                                                Text("Date")),
                                                        DataColumn(
                                                            label:
                                                                Text("Notes")),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(Text(
                                                              e['composite']
                                                                  ['date'])),
                                                          DataCell(Text(
                                                              e['composite']
                                                                  ['note']))
                                                        ])
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 10,
                                                    top: 20),
                                                child: const Text(
                                                  "Enrichment",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  return await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            content:
                                                                EditCompEnrich(
                                                          e: e,
                                                          edit: false,
                                                        ));
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 34, 78, 12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 5,
                                                      right: 20),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: const Text(
                                                    "Edit",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 8, right: 8, bottom: 8),
                                            child: Center(
                                              child: Card(
                                                elevation: 5,
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: DataTable(
                                                      headingRowHeight: 40,
                                                      columns: const [
                                                        DataColumn(
                                                            label:
                                                                Text("Date")),
                                                        DataColumn(
                                                            label:
                                                                Text("Notes")),
                                                      ],
                                                      rows: [
                                                        DataRow(cells: [
                                                          DataCell(Text(
                                                              e['enrichment']
                                                                  ['date'])),
                                                          DataCell(Text(
                                                              e['enrichment']
                                                                  ['note']))
                                                        ])
                                                      ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    left: 20,
                                                    bottom: 10,
                                                    top: 20),
                                                child: const Text(
                                                  "Palti Reports",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  // ignore: use_build_context_synchronously
                                                  return await showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return AlertDialog(
                                                            content:
                                                                AddNewPalti(
                                                          e: e,
                                                        ));
                                                      });
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 34, 78, 12),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8)),
                                                  margin: const EdgeInsets.only(
                                                      left: 20,
                                                      top: 10,
                                                      bottom: 5,
                                                      right: 20),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 5,
                                                      horizontal: 10),
                                                  child: const Text(
                                                    "Add New",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible:
                                                e['paltiReport'].isNotEmpty,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  left: 8, right: 8, bottom: 8),
                                              child: Center(
                                                child: Card(
                                                  elevation: 5,
                                                  child: SizedBox(
                                                    width: double.infinity,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: DataTable(
                                                        columns: const [
                                                          DataColumn(
                                                            label: Text("Date"),
                                                          ),
                                                          DataColumn(
                                                            label:
                                                                Text("Palti"),
                                                          ),
                                                          DataColumn(
                                                            label: Text(
                                                                "Temperature"),
                                                          ),
                                                          DataColumn(
                                                            label:
                                                                Text("Notes"),
                                                          ),
                                                        ],
                                                        rows: (e['paltiReport']
                                                                as List<
                                                                    dynamic>)
                                                            .map((keyvalue) {
                                                          return DataRow(
                                                              cells: [
                                                                DataCell(Text(
                                                                    keyvalue[
                                                                        'date'])),
                                                                DataCell(Text(keyvalue[
                                                                        'palti']
                                                                    .toString())),
                                                                DataCell(Text(keyvalue[
                                                                        'temperature']
                                                                    .toString())),
                                                                DataCell(Text(keyvalue[
                                                                        'note']
                                                                    .toString())),
                                                              ]);
                                                        }).toList(),
                                                      ),
                                                    ),

                                                    ///////Need to implement palti Report here
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return const Text("Loading..");
                                  }
                                }),
                          );
                          context.read<CommonBloc>().add(OpenBottomSheet(true));
                        },
                      );
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
                                context.read<ProductionBloc>().add(
                                    LoadProductions(limit: int.parse(value!)));
                              });
                            }),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (state.pageNumber > 1) {
                              bloc.add(LoadProductions(
                                  direction: "back",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.productions!.docs.first));
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
                            if (state.productions!.docs.length == state.limit) {
                              bloc.add(LoadProductions(
                                  direction: "forward",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.productions!.docs.last));
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
          return const Text("Error");
        }
      },
    );
  }

  purchaseDataTable(QuerySnapshot<Map<String, dynamic>> data) {
    data.docs.map((e) {
      return const Text("e");
    });
  }
}
