import 'package:abhay_chemicals/blocs/production_bloc/production_bloc.dart';
import 'package:abhay_chemicals/controllers/production_controller.dart';
import 'package:abhay_chemicals/widgets/add_new_with_title.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddProduction extends StatelessWidget {
  const AddProduction({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductionBloc, ProductionState>(
      builder: (context, state) {
        if (state is ProductionsLoading) {
          return const CircularProgressIndicator();
        } else if (state is ProductionsLoaded) {
          return Container(
            color: Colors.white,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: const AddNewWithTitle(
                      title: "Productions", routeName: "/addProduction"),
                ),
                ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: state.productions!.length,
                    itemBuilder: (context, index) {
                      var production = state.productions![index];
                      // print(batchQuantities);

                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.green[50],
                            borderRadius: BorderRadius.circular(12)),
                        margin:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Batch No : ",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("Created On : "),
                                Text("Composite Date : "),
                                Text("Last Palti Date : "),
                                Text("Enrichment Date : "),
                                Text("No of Palti : "),
                                Text("Quantities : "),

                                // Text()
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  production.batchNumber ?? "NA",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(production.date ?? "NA"),
                                Text(production.composite.cdate ?? "NA"),
                                Text(production.lastPaltidate ?? "NA"),
                                Text(production.enrichment.edate ?? "NA"),
                                Text((production.noOfPalti).toString() ?? "NA"),
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("purchase")
                                        .where("batchNumber",
                                            isEqualTo: production.batchNumber)
                                        .snapshots(),
                                    builder: (context, snapShot) {
                                      if (snapShot.hasData) {
                                        int quantities = 0;
                                        for (var i = 0;
                                            i < snapShot.data!.docs.length;
                                            i++) {
                                          quantities = quantities +
                                              (snapShot.data!.docs[i]
                                                  ['quantity'] as int);
                                        }

                                        return Text(quantities.toString());
                                      } else {
                                        return Text("Loading..");
                                      }
                                    })
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      );
                    })
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
