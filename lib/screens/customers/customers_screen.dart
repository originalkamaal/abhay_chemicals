import 'package:abhay_chemicals/blocs/common_bloc/common_bloc.dart';
import 'package:abhay_chemicals/blocs/customers_bloc/customers_bloc.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../widgets/list_actions_widget.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
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
      body: BlocBuilder<CustomersBloc, CustomerState>(
        builder: (context, state) {
          CustomersBloc bloc = context.read<CustomersBloc>();
          if (state is CustomersLoading) {
            return const Center(child: Text("Loading..."));
          } else if (state is CustomersLoaded) {
            return Container(
              color: Colors.white,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: const AddNewWithTitle(
                        title: "Customers", routeName: "/addCustomer"),
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
                          "Village",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                        DataColumn(
                            label: Text(
                          "Actions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                      ],
                      rows: state.customers!.docs.map((e) {
                        return DataRow(
                            onSelectChanged: (value) {
                              showModalBottomSheet(
                                  isDismissible: false,
                                  isScrollControlled: false,
                                  context: context,
                                  builder: (context) => Container(
                                        color: const Color.fromARGB(
                                            255, 237, 246, 237),
                                        child: SingleChildScrollView(
                                          child: Column(
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
                                                  },
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.only(
                                                    top: 10,
                                                    right: 10,
                                                    bottom: 10),
                                                child: Card(
                                                  child: Container(
                                                    width: double.maxFinite,
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const Text(
                                                              "Customer Name :"),
                                                          CustomText(
                                                              text: e['name']),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Customer Mobile :"),
                                                          CustomText(
                                                              text: e["phoneNumber"]
                                                                  .toString()),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Care of :"),
                                                          e.get("careOf") == ""
                                                              ? FutureBuilder(
                                                                  future: FirebaseFirestore
                                                                      .instance
                                                                      .doc((e['careOf']
                                                                              as DocumentReference)
                                                                          .path)
                                                                      .get(),
                                                                  builder:
                                                                      (context,
                                                                          snap) {
                                                                    return CustomText(
                                                                        text: snap
                                                                            .data!["name"]
                                                                            .toString());
                                                                  })
                                                              : Text(""),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Billing Addresss :"),
                                                          CustomText(
                                                              text: e[
                                                                  "billingAddress"]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Billing Pincode :"),
                                                          CustomText(
                                                              text: e["billingPincode"]
                                                                  .toString()),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Shipping Address :"),
                                                          CustomText(
                                                              text: e[
                                                                  "shippingAddress"]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Shipping Pincode :"),
                                                          CustomText(
                                                              text: e["shippingPincode"]
                                                                  .toString()),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          const Text(
                                                              "Village :"),
                                                          CustomText(
                                                              text:
                                                                  e["village"]),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                        ]),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                  enableDrag: false);
                              context
                                  .read<CommonBloc>()
                                  .add(OpenBottomSheet(true));
                            },
                            cells: [
                              DataCell(Text(e['name'])),
                              DataCell(Text(e['village'])),
                              dataTableActions(context, e, "/editCustomer"),
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
                                  context.read<CustomersBloc>().add(
                                      LoadCustomers(limit: int.parse(value!)));
                                });
                              }),
                        ),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              if (state.pageNumber > 1) {
                                bloc.add(LoadCustomers(
                                    direction: "back",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.customers!.docs.first));
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
                              if (state.customers!.docs.length == state.limit) {
                                bloc.add(LoadCustomers(
                                    direction: "forward",
                                    pageNumber: state.pageNumber,
                                    limit: state.limit,
                                    lastDoc: state.customers!.docs.last));
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

class CustomText extends StatelessWidget {
  final String text;
  const CustomText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
    );
  }
}
