import 'package:abhay_chemicals/widgets/line_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Padding lineChartByKamaal(
    {required List<String> field,
    required List<int> multipliers,
    required List<String> dataNames,
    required List<Color> colors,
    required List<List<Map<String, dynamic>>> docs,
    required String xName,
    required int noOfBars,
    required String yName}) {
  return Padding(
    padding: const EdgeInsets.only(left: 12.0, right: 20, top: 20, bottom: 10),
    child: SizedBox(
      height: 300,
      child: Builder(builder: (context) {
        List<List<double>> data = [];
        List<String> titles = [];
        int maxY = 0;
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

        DateTime current = DateTime.now();
        for (var i = 0; i < 12; i++) {
          int month = current.subtract(Duration(days: 30 * i)).month;
          int year = current.subtract(Duration(days: 30 * i)).year;
          monthlyData.add({
            "month": "${months[month - 1]}-$year",
            "value": field.map((e) => 0.0).toList()
          });
        }

        for (var i = 0; i < docs.length; i++) {
          var arr = docs[i];
          for (var obj in arr) {
            var month =
                "${months[DateTime.parse(obj['date']).month - 1]}-${DateTime.parse(obj['date']).year}";
            for (var j = 0; j < monthlyData.length; j++) {
              if (monthlyData[j]['month'] == month) {
                monthlyData[j]['value'][i] = monthlyData[j]['value'][i] +
                    (obj[field[i]]) * (multipliers[i]);
              }
            }
          }
        }

        monthlyData = monthlyData.reversed.toList();

        for (var i = monthlyData.length > noOfBars
                ? monthlyData.length - noOfBars
                : 0;
            i < monthlyData.length;
            i++) {
          List<double> k = [];
          for (var element in (monthlyData[i]['value'] as List<double>)) {
            k.add(element);
            if (element > maxY) {
              maxY = element.toInt();
            }
          }
          data.add(k);
          titles.add(monthlyData[i]['month']);
        }

        return ChartTwo(
            dataNames: dataNames,
            colors: colors,
            xName: xName,
            yName: yName,
            data: data,
            maxY: (maxY * 1.3).toInt(),
            titles: titles);
        //  ChartOne(
        //   maxY: 8,
        //   titles: titles,
        //   weeklySummary: weeklySummary,
        // );
      }),
    ),
  );
}
