import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartOne extends StatelessWidget {
  final List<List<double>> data;
  final int maxY;
  final List<Color> colors;
  final String xName;
  final List<String> dataNames;
  final String yName;
  final List<String> titles;
  const ChartOne({
    super.key,
    required this.data,
    required this.dataNames,
    required this.maxY,
    required this.titles,
    required this.colors,
    required this.xName,
    required this.yName,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(data: data);
    myBarData.initializeBarData();
    int colorCounter = 0;
    return BarChart(BarChartData(
        barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.grey.shade200,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            return BarTooltipItem("${dataNames[rodIndex]} = ${rod.toY}",
                const TextStyle(color: Colors.black));
          },
        )),
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
        barGroups: myBarData.barData.map((e) {
          colorCounter = 0;
          return BarChartGroupData(
              x: e.x,
              barsSpace: 1,
              // groupVertically: true,
              barRods: e.y.map((bar) {
                colorCounter++;
                return BarChartRodData(
                  toY: bar,
                  color: colors[colorCounter - 1],
                  width: 20,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                );
              }).toList()
              // [
              //   BarChartRodData(
              //     toY: e.y,
              //     color: Colors.green,
              //     width: 20,
              //     borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(5),
              //       topRight: Radius.circular(5),
              //     ),
              //   ),
              // ]
              );
        }).toList()));
  }

  Widget getBottomTiles(double value, TitleMeta meta) {
    const style = TextStyle(color: Colors.black, fontSize: 10);
    Widget text = Text(
      titles[value.toInt()],
      style: style,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}

class IndividualBar {
  final int x;
  final List<double> y;

  IndividualBar({required this.x, required this.y});
}

class BarData {
  final List<List<double>> data;

  BarData({required this.data});
  List<IndividualBar> barData = [];

  void initializeBarData({List<List<double>>? secondBar}) {
    for (var i = 0; i < data.length; i++) {
      barData.add(IndividualBar(x: i, y: data[i]));
    }
  }
}
