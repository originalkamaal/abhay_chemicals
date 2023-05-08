import 'package:abhay_chemicals/blocs/ordersales_bloc/ordersales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../blocs/common_bloc/common_bloc.dart';
import '../../widgets/add_new_with_title.dart';
import '../../widgets/list_actions_widget.dart';

class Sales extends StatefulWidget {
  const Sales({super.key});

  @override
  State<Sales> createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    var state = context.watch<OrderSaleBloc>().state;
    var bloc = context.read<OrderSaleBloc>();
    if (state is OrderSalesLoading) {
      return const Center(child: Text("Loading..."));
    } else if (state is OrderSalesLoaded) {
      return Container(
        color: Colors.white,
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: const AddNewWithTitle(
                  title: "Sales", routeName: "/addDirectSales"),
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
                      "orderId",
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
                  rows: state.orderSales!.docs.map((e) {
                    return DataRow(
                        onSelectChanged: (value) {
                          showModalBottomSheet(
                              isDismissible: false,
                              isScrollControlled: false,
                              context: context,
                              builder: (context) => Container(
                                    color: Color.fromRGBO(237, 246, 237, 1),
                                    child: ListView(
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
                                            },
                                          ),
                                        ),
                                        Card(
                                          child: DataTable(
                                            columns: [
                                              DataColumn(
                                                  label:
                                                      Text('Challan Number')),
                                              DataColumn(
                                                  label: Text(e['challanNumber']
                                                      .toString()))
                                            ],
                                            rows: [
                                              DataRow(cells: [
                                                DataCell(Text('Care Of')),
                                                DataCell(Text(e['careOf']))
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Customer')),
                                                DataCell(Text(e['customer']))
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Date')),
                                                DataCell(Text(e['date']))
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Item')),
                                                DataCell(
                                                    Text(e['item'].toString()))
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Quantity')),
                                                DataCell(Text(
                                                    e['quantity'].toString()))
                                              ]),
                                              DataRow(cells: [
                                                DataCell(Text('Village')),
                                                DataCell(Text(e['village']))
                                              ]),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                              enableDrag: false);
                          context.read<CommonBloc>().add(OpenBottomSheet(true));
                        },
                        cells: [
                          DataCell(Text((e.data().containsKey('OrderID'))
                              ? e['orderId'].toString()
                              : "Direct")),
                          DataCell(Text(e['date'])),
                          DataCell(Text(e['customer'])),
                          dataTableActions(context, e, "/editSales"),
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
                        style: TextStyle(fontSize: 12.sp, color: Colors.black),
                        dropdownColor: const Color.fromARGB(255, 237, 246, 237),
                        value: selectedCount,
                        items: items.map((e) {
                          return DropdownMenuItem(value: e, child: Text(e));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCount = value.toString();
                            bloc.add(LoadOrderSales(limit: int.parse(value!)));
                          });
                        }),
                  ),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (state.pageNumber > 1) {
                          bloc.add(LoadOrderSales(
                              direction: "back",
                              pageNumber: state.pageNumber,
                              limit: state.limit,
                              lastDoc: state.orderSales!.docs.first));
                        }
                      },
                      child: Container(
                        color: const Color.fromARGB(255, 237, 246, 237),
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.chevron_left)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (state.orderSales!.docs.length == state.limit) {
                          bloc.add(LoadOrderSales(
                              direction: "forward",
                              pageNumber: state.pageNumber,
                              limit: state.limit,
                              lastDoc: state.orderSales!.docs.last));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 20),
                        color: const Color.fromARGB(255, 237, 246, 237),
                        padding: const EdgeInsets.all(5),
                        child: const Center(child: Icon(Icons.chevron_right)),
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
      return Text("Loading");
    }
  }
}
