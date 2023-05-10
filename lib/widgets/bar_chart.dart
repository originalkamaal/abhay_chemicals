import 'package:abhay_chemicals/screens/home/home.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartOne extends StatelessWidget {
  final List<double> weeklySummary;
  final int maxY;
  final String xName;
  final String yName;
  final List<String> titles;
  const ChartOne({
    super.key,
    required this.weeklySummary,
    required this.maxY,
    required this.titles,
    required this.xName,
    required this.yName,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(data: weeklySummary);
    myBarData.initializeBarData();
    print("data $weeklySummary");
    print("titles $titles");
    return BarChart(BarChartData(
        minY: 0,
        maxY: maxY.toDouble(),
        // gridData: FlGridData(show: false),
        // borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              axisNameWidget: Text(yName),
              sideTitles: SideTitles(showTitles: true, reservedSize: 60)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
              axisNameWidget: Text(xName),
              sideTitles: SideTitles(
                  showTitles: true, getTitlesWidget: getBottomTiles)),
        ),
        baselineY: 0,
        alignment: BarChartAlignment.spaceAround,
        barGroups: myBarData.barData
            .map((e) => BarChartGroupData(
                    x: e.x,
                    barsSpace: 50,
                    groupVertically: true,
                    barRods: [
                      BarChartRodData(
                          toY: e.y,
                          color: Colors.green,
                          width: 20,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)))
                    ]))
            .toList()));
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    Widget text;
    if (titles[value.toInt()] != null) {
      print("kamal ${titles[value.toInt()]}");
      text = Text(
        titles[value.toInt()],
        style: style,
      );
    } else {
      text = Text(
        "",
        style: style,
      );
    }

    return SideTitleWidget(child: text, axisSide: meta.axisSide);
  }
}

class IndividualBar {
  final int x;
  final double y;

  IndividualBar({required this.x, required this.y});
}

class BarData {
  final List<double> data;

  BarData({required this.data});
  List<IndividualBar> barData = [];

  void initializeBarData() {
    for (var i = 0; i < data.length; i++) {
      barData.add(IndividualBar(x: i, y: data[i]));
    }
  }
}
