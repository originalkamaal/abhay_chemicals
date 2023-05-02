import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/add_new_with_title.dart';
import '../../widgets/list_actions_widget.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
        ExpenseBloc bloc = context.read<ExpenseBloc>();
        if (state is ExpenseLoaded) {
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
                    showCheckboxColumn: false,
                    columnSpacing: 1,
                    headingRowColor: MaterialStateProperty.resolveWith<Color>(
                        (states) => const Color.fromARGB(255, 237, 246, 237)),
                    columns: const [
                      DataColumn(
                          label: Text(
                        "Date",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Amount",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      DataColumn(
                          label: Text(
                        "Actions",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                    ],
                    rows: state.expense!.docs.map((e) {
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
                                                    .add(OpenBottomSheet(true));
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
                            DataCell(Text(e['date'])),
                            DataCell(Text(e['amount'].toString())),
                            DataCell(Text(e['description'])),
                            dataTableActions(context, e, "/"),
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
                                context
                                    .read<ExpenseBloc>()
                                    .add(LoadExpense(limit: int.parse(value!)));
                              });
                            }),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (state.pageNumber > 1) {
                              bloc.add(LoadExpense(
                                  direction: "back",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.expense!.docs.first));
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
                            if (state.expense!.docs.length == state.limit) {
                              bloc.add(LoadExpense(
                                  direction: "forward",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.expense!.docs.last));
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
}
