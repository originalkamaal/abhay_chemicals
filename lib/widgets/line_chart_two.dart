import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartTwo extends StatelessWidget {
  final List<List<double>> data;
  final int maxY;
  final List<Color> colors;
  final String xName;
  final List<String> dataNames;
  final String yName;
  final List<String> titles;
  const ChartTwo({
    super.key,
    required this.colors,
    required this.data,
    required this.dataNames,
    required this.maxY,
    required this.titles,
    required this.xName,
    required this.yName,
  });

  @override
  Widget build(BuildContext context) {
    BarData myBarData = BarData(data: data);
    myBarData.initializeBarData();
    return LineChart(
      LineChartData(
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey.shade200,
                getTooltipItems: (value) {
                  return value.map((e) {
                    return LineTooltipItem("${dataNames[e.barIndex]} = ${e.y}",
                        const TextStyle(color: Colors.black));
                  }).toList();
                })),
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
        lineBarsData: lineBarsData(myBarData.barData, colors),
      ),
    );
  }

  List<LineChartBarData> lineBarsData(
      List<IndividualBar> barData, List<Color> colors) {
    List<LineChartBarData> bars = [];
    for (var i = 0; i < barData[0].y.length; i++) {
      bars.add(LineChartBarData(
          isCurved: true,
          color: colors[i],
          preventCurveOverShooting: true,
          spots: barData.map((e) => FlSpot(e.x.toDouble(), e.y[i])).toList()));
    }
    return bars;
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
