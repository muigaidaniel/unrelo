import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({super.key});

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  late List<WeatherData> weatherData;
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    weatherData = getData();
    tooltipBehavior = TooltipBehavior(enable: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      child: SfCartesianChart(
        plotAreaBorderColor: Colors.transparent,
        tooltipBehavior: tooltipBehavior,
        series: <ChartSeries>[
          SplineSeries<WeatherData, String>(
              dataSource: weatherData,
              name: 'Temperature (°C)',
              xValueMapper: (WeatherData data, _) => data.month,
              yValueMapper: (WeatherData data, _) => data.temp),
          SplineSeries<WeatherData, String>(
              dataSource: weatherData,
              name: 'Humidity (%)',
              xValueMapper: (WeatherData data, _) => data.month,
              yValueMapper: (WeatherData data, _) => data.humidity),
        ],
        legend: Legend(
            isVisible: true,
            position: LegendPosition.bottom,
            overflowMode: LegendItemOverflowMode.wrap,
            textStyle: const TextStyle(color: Colors.white)),
        primaryXAxis: CategoryAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: const TextStyle(color: Colors.white)),
        primaryYAxis: NumericAxis(
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            minimum: 10,
            maximum: 40,
            interval: 10,
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  List<WeatherData> getData() {
    final List<WeatherData> weatherData = [
      WeatherData('Jan', 26, 14),
      WeatherData('Feb', 28, 18),
      WeatherData('Mar', 24, 16),
      WeatherData('Apr', 25, 17),
      WeatherData('May', 23, 15),
    ];
    return weatherData;
  }
}

class WeatherData {
  WeatherData(this.month, this.temp, this.humidity);

  final String month;
  final int temp;
  final int humidity;
}
