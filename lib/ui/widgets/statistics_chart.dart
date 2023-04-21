import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';

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
        tooltipBehavior: tooltipBehavior,
        series: <ChartSeries<WeatherData, double>>[
          LineSeries<WeatherData, double>(
            dataSource: weatherData,
            xValueMapper: (WeatherData weather, _) => weather.day,
            yValueMapper: (WeatherData weather, _) => weather.temp,
          )
        ],
        primaryXAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          minimum: 1,
          maximum: 10,
          interval: 1,
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          minimum: 0,
          maximum: 100,
          interval: 10,
          majorGridLines: const MajorGridLines(width: 0),
        ),
      ),
    );
  }

  List<WeatherData> getData() {
    final List<WeatherData> weatherData = [
      WeatherData(29, 14, 1),
      WeatherData(28, 18, 2),
      WeatherData(24, 16, 3),
      WeatherData(25, 17, 4),
      WeatherData(23, 15, 5),
    ];
    return weatherData;
  }
}

class WeatherData {
  WeatherData(this.temp, this.humidity, this.day);

  final double temp;
  final double humidity;
  final double day;
}
