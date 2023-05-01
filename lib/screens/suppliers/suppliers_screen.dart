import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/suppliers_bloc/suppliers_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:abhay_chemicals/widgets/list_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Suppliers extends StatefulWidget {
  const Suppliers({super.key});

  @override
  State<Suppliers> createState() => _SuppliersState();
}

class _SuppliersState extends State<Suppliers> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "assets/images/logo.png",
          height: 60,
          fit: BoxFit.fitHeight,
        ),
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actionsIconTheme: const IconThemeData(color: Colors.black),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined)),
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_outlined)),
        ],
      ),
      body: BlocBuilder<SuppliersBloc, SuppliersState>(
        builder: (context, state) {
          SuppliersBloc bloc = context.read<SuppliersBloc>();
          if (state is SuppliersLoading) {
            return const Center(child: Text("Loading..."));
          } else if (state is SuppliersLoaded) {
            return Container(
              color: Colors.white,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const AddNewWithTitle(
                        title: "Suppliers", routeName: "/addProductions"),
                  ),
                  DataTable(
                      showCheckboxColumn: false,
                      columnSpacing: 1,
                      headingRowColor: MaterialStateProperty.resolveWith<Color>(
                          (states) => const Color.fromARGB(255, 237, 246, 237)),
                      columns: const [
                        DataColumn(
                            label: Text(
                          "Name",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Email",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                      rows: state.suppliers!.docs.map((e) {
                        return DataRow(
                          cells: [
                            DataCell(Text(e['name'])),
                            DataCell(Text(e['email'])),
                            dataTableActions(context, e.reference),
                          ],
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
                        );
                      }).toList()),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton(
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                              dropdownColor:
                                  const Color.fromARGB(255, 237, 246, 237),
                              value: selectedCount,
                              items: items.map((e) {
                                return DropdownMenuItem(
                                    value: e, child: Text(e));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  selectedCount = value.toString();
                                  context.read<SuppliersBloc>().add(
                                      LoadSuppliers(limit: int.parse(value!)));
                                });
                              }),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (state.pageNumber > 1) {
                                bloc.add(LoadSuppliers(
                                    direction: "back",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.suppliers!.docs.first));
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
                              if (state.suppliers!.docs.length == state.limit) {
                                bloc.add(LoadSuppliers(
                                    direction: "forward",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.suppliers!.docs.last));
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, right: 20),
                              color: const Color.fromARGB(255, 237, 246, 237),
                              padding: const EdgeInsets.all(5),
                              child: const Center(
                                  child: Icon(Icons.chevron_right)),
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
      ),
    );
  }
}
