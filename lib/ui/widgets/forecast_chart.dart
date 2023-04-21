import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';

class ForecastChart extends StatefulWidget {
  const ForecastChart({super.key});

  @override
  State<ForecastChart> createState() => _ForecastChartState();
}

class _ForecastChartState extends State<ForecastChart> {
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
    return CustomContainer(
      height: 35.h,
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Text('5 Day Forecast',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            height: 25.h,
            child: SfCartesianChart(
              plotAreaBorderColor: Colors.transparent,
              tooltipBehavior: tooltipBehavior,
              series: <ChartSeries<WeatherData, double>>[
                StackedLineSeries<WeatherData, double>(
                  dataSource: weatherData,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(
                      textStyle: TextStyle(color: Colors.white),
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.bottom),
                  xValueMapper: (WeatherData weather, _) => weather.day,
                  yValueMapper: (WeatherData weather, _) => weather.temp,
                ),
                StackedLineSeries<WeatherData, double>(
                  dataSource: weatherData,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(
                      textStyle: TextStyle(color: Colors.white),
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top),
                  xValueMapper: (WeatherData weather, _) => weather.day,
                  yValueMapper: (WeatherData weather, _) => weather.humidity,
                )
              ],
              primaryXAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  minimum: 1,
                  maximum: 5,
                  interval: 1,
                  majorGridLines: const MajorGridLines(width: 0),
                  majorTickLines: const MajorTickLines(size: 0),
                  axisLine: const AxisLine(width: 0),
                  opposedPosition: true,
                  labelStyle: const TextStyle(color: Colors.white)),
              primaryYAxis: NumericAxis(
                  edgeLabelPlacement: EdgeLabelPlacement.shift,
                  minimum: 10,
                  maximum: 60,
                  interval: 10,
                  majorGridLines: const MajorGridLines(width: 0),
                  isVisible: false),
            ),
          ),
        ],
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
