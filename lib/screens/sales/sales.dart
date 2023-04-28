import 'package:abhay_chemicals/blocs/sales_bloc/sales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/add_new_with_title.dart';

class AddSales extends StatefulWidget {
  const AddSales({super.key});

  @override
  State<AddSales> createState() => _AddSalesState();
}

class _AddSalesState extends State<AddSales> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesBloc, SalesState>(
      builder: (context, state) {
        if (state is SalesLoading) {
          return const Center(
            child: Text("Loading"),
          );
        } else if (state is SalesLoaded) {
          return Container(
            color: Colors.white,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  child: const AddNewWithTitle(
                      title: "Sales", routeName: "/addPurchase"),
                ),
                ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: state.sales
                        .map((e) => Container(
                              padding: const EdgeInsets.only(
                                  left: 20, right: 20, top: 20),
                              child: Container(
                                padding: EdgeInsets.all(12),
                                color: Colors.green[50],
                                child: Column(
                                  children: [
                                    Text("asdf"),
                                    Text("Care Of : ${e.careOf}"),
                                    Text("Challan No : ${e.challanNo}"),
                                    Text("Customer : ${e.customer}"),
                                    Text("Date : ${e.date}"),
                                    Text("Item : ${e.item}"),
                                    Text("order Id : ${e.orderId}"),
                                    Text("Phone No : ${e.phoneNo}"),
                                    Text("Quantity : ${e.quantity}"),
                                    Text("Village : ${e.village}"),
                                  ],
                                ),
                              ),
                            ))
                        .toList())
              ],
            ),
          );
        } else {
          return Center(
            child: Text("Something Went wrong"),
          );
        }
      },
    );
  }
}
