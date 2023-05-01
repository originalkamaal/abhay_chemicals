import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
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
                            dataTableActions(context, e.reference),
                          ],
                          onSelectChanged: (value) {
                            Scaffold.of(context)
                                .showBottomSheet((context) => Container(
                                      color: Colors.red,
                                      height: 500,
                                    ));
                          });
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
                            print("Is first page ${state.pageNumber}");
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
                            print("Is first page ${state.pageNumber}");
                            if (state.productions!.docs.length == state.limit) {
                              bloc.add(LoadProductions(
                                  direction: "forward",
                                  pageNumber: state.pageNumber,
                                  limit: state.limit,
                                  lastDoc: state.productions!.docs.last));
                              print(state.productions!.docs.length);
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
