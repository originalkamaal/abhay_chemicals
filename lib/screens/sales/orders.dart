import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/order_bloc/order_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
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
                      title: "Orders", routeName: "/addSales"),
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
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (context) => Container(
                                        height: 350.h,
                                        color: const Color.fromARGB(
                                            255, 237, 246, 237),
                                        child: Column(
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
                                                      .add(OpenBottomSheet(
                                                          true));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                  enableDrag: false);
                              context
                                  .read<CommonBloc>()
                                  .add(OpenBottomSheet(true));
                            },
                            cells: [
                              DataCell(Text(e['orderId'].toString())),
                              DataCell(Text(e['date'])),
                              DataCell(Text(e['customer'])),
                              dataTableActions(context, e, "/"),
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
          return Text("Loading...");
        }
      },
    );
  }
}
