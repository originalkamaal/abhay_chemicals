import 'package:abhay_chemicals/widgets/bar_chart.dart';
import 'package:abhay_chemicals/widgets/bar_chart_widget.dart';
import 'package:abhay_chemicals/widgets/input_widgets.dart';
import 'package:abhay_chemicals/widgets/metrix_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chartTitle("Sales"),
              BarChartByKamaal(
                  noOfBars: 5,
                  collection: "sales",
                  field: "quantity",
                  xName: "Months",
                  yName: "Quantity"),
              chartTitle("Expenses"),
              BarChartByKamaal(
                  noOfBars: 5,
                  collection: "expenses",
                  field: "amount",
                  xName: "Months",
                  yName: "Amount"),
              chartTitle("Productions"),
              BarChartByKamaal(
                  noOfBars: 5,
                  collection: "purchase",
                  field: "quantity",
                  xName: "Months",
                  yName: "Quantity"),
            ],
          ),
        ),
      ),
    );
  }

  Container chartTitle(title) {
    return Container(
        padding: EdgeInsets.only(left: 20, top: 10),
        child: Text(
          title,
          style: TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ));
  }
}
