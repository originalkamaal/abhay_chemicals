import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/order_bloc/order_bloc.dart';
import 'package:abhay_chemicals/controllers/orders_controller.dart';
import 'package:abhay_chemicals/widgets/add_new_sales.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/list_actions_widget.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrdersState>(
      builder: (context, state) {
        OrderBloc bloc = context.read<OrderBloc>();
        if (state is OrdersLoading) {
          return const Center(child: Text("Loading..."));
        } else if (state is OrdersLoaded) {
          return Container(
            color: Colors.white,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const AddNewWithTitle(
                      title: "Orders", routeName: "/addOrders"),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 1,
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => const Color.fromARGB(255, 237, 246, 237)),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "ID",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Date",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Customer",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                      rows: state.orders!.docs.map((e) {
                        return DataRow(
                            onSelectChanged: (value) {
                              showModalBottomSheet(
                                isScrollControlled: true,
                                useSafeArea: true,
                                enableDrag: false,
                                context: context,
                                backgroundColor:
                                    const Color.fromARGB(255, 237, 246, 237),
                                builder: (context) => FutureBuilder(
                                    future: OrdersController()
                                        .getSalesByOrderId(e['orderId']),
                                    builder: (context, doc) {
                                      if (doc.hasData) {
                                        List<
                                                QueryDocumentSnapshot<
                                                    Map<String, dynamic>>> ddd =
                                            doc.data!.docs;
                                        return SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    context
                                                        .read<CommonBloc>()
                                                        .add(OpenBottomSheet(
                                                            true));
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                  left: 20,
                                                  bottom: 10,
                                                ),
                                                child: Text(
                                                  "Order ID #${e['orderId'].toString()}",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                              Container(
                                                margin: const EdgeInsets.only(
                                                    left: 8,
                                                    right: 8,
                                                    bottom: 10),
                                                width: double.maxFinite,
                                                child: Card(
                                                  elevation: 5,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
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
                                                              Text("Date : "),
                                                              Text(
                                                                  "Customer :"),
                                                              Text("Product :"),
                                                              Text(
                                                                  "Quantity :"),
                                                              Text(
                                                                  "Fullfilled :"),
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
                                                              Text(e['date']),
                                                              Text(e[
                                                                  'customer']),
                                                              Text(e['item']),
                                                              Text(e['quantity']
                                                                  .toString()),
                                                              Text(e['fulfilled']
                                                                  .toString()),
                                                            ],
                                                          )
                                                        ]),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            bottom: 10,
                                                            top: 20),
                                                    child: const Text(
                                                      "Sales",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () async {
                                                      return await showDialog(
                                                          barrierDismissible:
                                                              false,
                                                          context: context,
                                                          builder: (context) {
                                                            return AlertDialog(
                                                                content:
                                                                    AddNewSales(
                                                              e: e,
                                                            ));
                                                          });
                                                    },
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 34, 78, 12),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8)),
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              top: 10,
                                                              bottom: 5,
                                                              right: 20),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 5,
                                                          horizontal: 10),
                                                      child: const Text(
                                                        "Add New Sales",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Visibility(
                                                visible: ddd.isEmpty,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      width: double.maxFinite,
                                                      child: const Center(
                                                          child: Text(
                                                              "No Records")),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: ddd.isNotEmpty,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Card(
                                                    elevation: 5,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: DataTable(
                                                          columnSpacing: 5,
                                                          columns: const [
                                                            DataColumn(
                                                                label: Text(
                                                                    "Date")),
                                                            DataColumn(
                                                                label: Text(
                                                                    "Challan No")),
                                                            DataColumn(
                                                                label: Text(
                                                                    "Customer")),
                                                            DataColumn(
                                                                label: Text(
                                                                    "Quantity")),
                                                          ],
                                                          rows: ddd.map((ess) {
                                                            return DataRow(
                                                                cells: [
                                                                  DataCell(Text(
                                                                      ess['date']
                                                                          .toString())),
                                                                  DataCell(
                                                                      Center(
                                                                    child: Text(
                                                                        ess['challanNumber']
                                                                            .toString()),
                                                                  )),
                                                                  DataCell(Text(
                                                                      ess['customer']
                                                                          .toString())),
                                                                  DataCell(
                                                                      Center(
                                                                    child: Text(
                                                                        ess['quantity']
                                                                            .toString()),
                                                                  )),
                                                                ]);
                                                          }).toList()),
                                                    ),

                                                    // children:
                                                    //     ddd.map((es) {
                                                    //   return Text(es[
                                                    //           'orderId']
                                                    //       .toString());
                                                    // }).toList(),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      } else {
                                        return const Text("Loading..");
                                      }
                                    }),
                              );
                              context
                                  .read<CommonBloc>()
                                  .add(OpenBottomSheet(true));
                            },
                            cells: [
                              DataCell(Text(e['orderId'].toString())),
                              DataCell(Text(e['date'])),
                              DataCell(Text(e['customer'])),
                              dataTableActions(context, e, "/editOrder"),
                            ]);
                      }).toList()),
                ),
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
                                bloc.add(LoadOrders(limit: int.parse(value!)));
                              });
                            }),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (state.pageNumber > 1) {
                              bloc.add(LoadOrders(
                                  direction: "back",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.orders!.docs.first));
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
                            if (state.orders!.docs.length == state.limit) {
                              bloc.add(LoadOrders(
                                  direction: "forward",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.orders!.docs.last));
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
          return const Text("Loading...");
        }
      },
    );
  }
}
