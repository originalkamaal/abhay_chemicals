import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/widgets/bar_chart_widget.dart';
import 'package:abhay_chemicals/widgets/line_chart_two_widget.dart';
import 'package:abhay_chemicals/widgets/line_chart_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
              FutureBuilder(
                future: FirebaseFirestore.instance
                    .collection("sales")
                    .orderBy("date", descending: false)
                    .get(),
                builder: (context, snapShot1) {
                  if (snapShot1.hasData) {
                    return Column(
                      children: [
                        FutureBuilder(
                            future: FirebaseFirestore.instance
                                .collection("expenses")
                                .orderBy("date", descending: false)
                                .get(),
                            builder: (context, snapShot2) {
                              if (snapShot2.hasData) {
                                return Column(
                                  children: [
                                    chartTitle("Sales & Expenses (Monthly)"),
                                    Card(
                                      elevation: 5,
                                      child: barChartByKamaal(
                                          dataNames: [
                                            "Purchase",
                                            "Sales"
                                          ],
                                          field: [
                                            "quantity",
                                            "amount"
                                          ],
                                          colors: [
                                            Colors.green.shade900,
                                            Colors.green.shade600
                                          ],
                                          docs: [
                                            snapShot1.data!.docs,
                                            snapShot2.data!.docs
                                          ],
                                          multipliers: [
                                            50,
                                            1
                                          ],
                                          xName: "Months",
                                          noOfBars: 5,
                                          yName: "Quantity"),
                                    ),
                                    chartTitle("Expenses (Monthly)"),
                                    Card(
                                      elevation: 5,
                                      child: barChartByKamaal(
                                          dataNames: [
                                            "Purchase",
                                            "Sales"
                                          ],
                                          field: [
                                            "amount"
                                          ],
                                          multipliers: [
                                            1
                                          ],
                                          colors: [
                                            Colors.green.shade900,
                                            Colors.green.shade600
                                          ],
                                          docs: [
                                            snapShot2.data!.docs
                                          ],
                                          xName: "Months",
                                          noOfBars: 5,
                                          yName: "Amount"),
                                    ),
                                    FutureBuilder(
                                        future: FirebaseFirestore.instance
                                            .collection("purchase")
                                            .get(),
                                        builder: (context, snapShot3) {
                                          if (snapShot3.hasData) {
                                            return Column(
                                              children: [
                                                chartTitle(
                                                    "Purchase (Monthly)"),
                                                Card(
                                                  elevation: 5,
                                                  child: lineChartByKamaal(
                                                      dataNames: [
                                                        "Purchase",
                                                      ],
                                                      field: [
                                                        "quantity",
                                                      ],
                                                      multipliers: [
                                                        1
                                                      ],
                                                      docs: [
                                                        snapShot3.data!.docs
                                                            .map(
                                                                (e) => e.data())
                                                            .toList(),
                                                      ],
                                                      colors: [
                                                        Colors.green.shade900,
                                                      ],
                                                      xName: "Months",
                                                      noOfBars: 5,
                                                      yName: "Quantity"),
                                                ),
                                              ],
                                            );
                                          } else {
                                            return const Text("");
                                          }
                                        }),
                                    FutureBuilder(
                                        future: ProductionController()
                                            .getAllPurchaseWithQuantity(),
                                        builder: (context, snapShot4) {
                                          // print(snapShot4.data);

                                          return Column(
                                            children: [
                                              chartTitle(
                                                  "Productions ( Monthly)"),
                                              Card(
                                                elevation: 5,
                                                child: lineChartByKamaal(
                                                    field: [
                                                      "quantity"
                                                    ],
                                                    multipliers: [
                                                      1
                                                    ],
                                                    dataNames: [
                                                      'dataNames'
                                                    ],
                                                    colors: [
                                                      Colors.green.shade900
                                                    ],
                                                    docs: [
                                                      snapShot4.data
                                                    ],
                                                    xName: "Months",
                                                    noOfBars: 6,
                                                    yName: 'Quantity'),
                                              ),
                                            ],
                                          );
                                          return Container();
                                        }),
                                    lineChartByKamaalTwo(
                                        field: [
                                          "quantity"
                                        ],
                                        multipliers: [
                                          1
                                        ],
                                        dataNames: [
                                          "CareofSales"
                                        ],
                                        colors: [
                                          Colors.green.shade900
                                        ],
                                        docs: [
                                          snapShot1.data!.docs
                                              .map((e) => e.data())
                                              .toList()
                                        ],
                                        xName: "Care Ofs",
                                        noOfBars: 5,
                                        yName: "Quantity"),
                                  ],
                                );
                              } else {
                                return const Text("Loading..");
                              }
                            }),
                      ],
                    );
                  } else {
                    return const Text("Loading..");
                  }
                },
              )
              // barChartByKamaal(
              //     noOfBars: 5,
              //     collection: "sales",
              //     field: "quantity",
              //     xName: "Months",
              //     yName: "Quantity"),
            ],
          ),
        ),
      ),
    );
  }

  Container chartTitle(title) {
    return Container(
        padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
        child: Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontFamily: "Poppins"),
        ));
  }
}
