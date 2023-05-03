import 'package:abhay_chemicals/screens/sales/orders.dart';
import 'package:abhay_chemicals/screens/sales/sales.dart';
import 'package:flutter/material.dart';

class OrdersAndSales extends StatefulWidget {
  const OrdersAndSales({super.key});

  @override
  State<OrdersAndSales> createState() => _OrdersAndSalesState();
}

class _OrdersAndSalesState extends State<OrdersAndSales> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          flexibleSpace: const SafeArea(
            child:
                TabBar(indicatorColor: Color.fromARGB(255, 34, 78, 12), tabs: [
              Tab(
                child: Text(
                  "Orders",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              Tab(
                child: Text(
                  "Sales",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ]),
          ),
        ),
        body: const TabBarView(
          children: [
            Orders(),
            Sales()

            //Sales
          ],
        ),
      ),
    );
  }
}
