import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CareOfChart extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  const CareOfChart({super.key, required this.data});

  @override
  State<CareOfChart> createState() => _CareOfChartState();
}

class _CareOfChartState extends State<CareOfChart> {
  late final List<Map<String, dynamic>> data;

  final List<String> months = [
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
  @override
  void initState() {
    super.initState();
    data = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return LineChart(LineChartData(
        lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
                tooltipBgColor: Colors.grey.shade200,
                getTooltipItems: (value) {
                  return value.map((e) {
                    return LineTooltipItem("Quantity = ${e.y}",
                        const TextStyle(color: Colors.black));
                  }).toList();
                })),
        minY: 0,
        // gridData: FlGridData(show: false),
        // borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
              axisNameWidget: const Text("Quantity"),
              sideTitles: SideTitles(showTitles: true, reservedSize: 60)),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            axisNameWidget: const Text("Careof"),
          ),
        ),
        lineBarsData: lineBarsData(data)));
  }

  List<LineChartBarData>? lineBarsData(List<Map<String, dynamic>> data) {
    List<LineChartBarData> list = [];
    return list;
  }
}
