import 'package:abhay_chemicals/blocs/user_bloc/user_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> items = ["3", "10", "20", "30", "50"];
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
                        title: "Users", routeName: "/addProductions"),
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
                          "Actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                      rows: state.users!.docs.map((e) {
                        return DataRow(cells: [
                          DataCell(Text(e['id'])),
                          DataCell(Text(e['id'])),
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
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.black),
                              elevation: 10,
                              dropdownColor:
                                  const Color.fromARGB(255, 237, 246, 237),
                              value: "10",
                              items: items
                                  .map((e) => DropdownMenuItem(
                                      value: e, child: Text(e)))
                                  .toList(),
                              onChanged: (value) {
                                context
                                    .read<UsersBloc>()
                                    .add(LoadUsers(limit: int.parse(value!)));
                              }),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              print("Is first page ${state.pageNumber}");
                              if (state.pageNumber > 1) {
                                bloc.add(LoadUsers(
                                    direction: 0,
                                    limit: state.limit,
                                    lastDoc: state.users!.docs.last));
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
                                    direction: 1,
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
