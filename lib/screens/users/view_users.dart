import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/user_bloc/user_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:abhay_chemicals/widgets/list_actions_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Admin extends StatefulWidget {
  const Admin({super.key});

  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  List<String> items = ["10", "20", "30", "50"];
  String selectedCount = "10";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          UsersBloc bloc = context.read<UsersBloc>();
          if (state is UsersLoading) {
            return const Center(child: Text("Loading..."));
          } else if (state is UsersLoaded) {
            return Container(
              color: Colors.white,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const AddNewWithTitle(
                        title: "Users", routeName: "/addAdmin"),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                        showCheckboxColumn: false,
                        columnSpacing: 1,
                        headingRowColor:
                            MaterialStateProperty.resolveWith<Color>((states) =>
                                const Color.fromARGB(255, 237, 246, 237)),
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
                            "Mobile",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(
                              label: Text(
                            "Actions",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ))
                        ],
                        rows: state.users!.docs.map((e) {
                          return DataRow(
                            cells: [
                              DataCell(Text(e['name'])),
                              DataCell(Text(e['email'])),
                              DataCell(Text(e['phoneNumber'].toString())),
                              dataTableActions(context, e, "/editAdmin"),
                            ],
                          );
                        }).toList()),
                  ),
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
                                  context
                                      .read<UsersBloc>()
                                      .add(LoadUsers(limit: int.parse(value!)));
                                });
                              }),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (state.pageNumber > 1) {
                                bloc.add(LoadUsers(
                                    direction: "back",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.users!.docs.first));
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
                              if (state.users!.docs.length == state.limit) {
                                bloc.add(LoadUsers(
                                    direction: "forward",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.users!.docs.last));
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
