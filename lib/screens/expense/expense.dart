import 'package:abhay_chemicals/blocs/expense_bloc/expense_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/add_new_with_title.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  @override
  Widget build(BuildContext context) {
    List<String> items = ["10", "20", "30", "50"];
    return BlocBuilder<ExpenseBloc, ExpenseState>(
      builder: (context, state) {
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
                    rows: state.expense.map((e) {
                      return DataRow(cells: [
                        DataCell(Text(e.date)),
                        DataCell(Text(e.amount)),
                        DataCell(Text(e.description)),
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
}
