import 'package:abhay_chemicals/widgets/bar_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Padding BarChartByKamaal(
    {required String collection,
    required String field,
    required String xName,
    required int noOfBars,
    required String yName}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 20, top: 20, bottom: 10),
    child: SizedBox(
      height: 300,
      child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection(collection)
              .orderBy("date", descending: false)
              .get(),
          builder: (context, snapShot) {
            List<double> data = [];
            List<String> titles = [];
            int maxY = 0;
            if (snapShot.hasData) {
              List<String> months = [
                "JAN",
                "FEB",
                "MAR",
                "APR",
                "MAY",
                "JUN",
                "JUL",
                "AUG",
                "SEP",
                "OCT",
                "NOV",
                "DEC"
              ];
              var monthlyData = [];
              var arr = snapShot.data!.docs;
              arr.forEach((obj) {
                var month =
                    "${months[DateTime.parse(obj['date']).month - 1]}-${DateTime.parse(obj['date']).year}";
                // print("$month - ${obj['date']}");
                bool index = false;
                for (var i = 0; i < monthlyData.length; i++) {
                  if (monthlyData[i]['month'] == month) {
                    monthlyData[i]['value'] =
                        monthlyData[i]['value'] + obj[field];
                    index = true;
                  }
                }
                if (index == false) {
                  monthlyData.add({"month": month, "value": obj[field]});
                }
              });

              for (var i = monthlyData.length > noOfBars
                      ? monthlyData.length - noOfBars
                      : 0;
                  i < monthlyData.length;
                  i++) {
                if (monthlyData[i]['value'] > maxY) {
                  maxY = monthlyData[i]['value'];
                }
                data.add((monthlyData[i]['value'] as int).toDouble());
                titles.add(monthlyData[i]['month']);
              }

              print(data);
              print(titles);
              print(maxY);

              // print(monthlyData);
              // monthlyData.sort((a, b) =>
              //     months.indexOf(b['month']) - months.indexOf(a['month']));
              // print(monthlyData);
              return ChartOne(
                  xName: xName,
                  yName: yName,
                  weeklySummary: data,
                  maxY: (maxY * 1.3).toInt(),
                  titles: titles);
              //  ChartOne(
              //   maxY: 8,
              //   titles: titles,
              //   weeklySummary: weeklySummary,
              // );
            } else
              return Container();
          }),
    ),
  );
}
