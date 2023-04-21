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
      height: 33.h,
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
              series: <ChartSeries<WeatherData, String>>[
                StackedLineSeries<WeatherData, String>(
                  dataSource: weatherData,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(
                      textStyle: TextStyle(color: Colors.white),
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.bottom),
                  name: 'Temperature (°C)',
                  xValueMapper: (WeatherData weather, _) => weather.day,
                  yValueMapper: (WeatherData weather, _) => weather.temp,
                ),
                StackedLineSeries<WeatherData, String>(
                  dataSource: weatherData,
                  markerSettings: const MarkerSettings(isVisible: true),
                  dataLabelSettings: const DataLabelSettings(
                      textStyle: TextStyle(color: Colors.white),
                      isVisible: true,
                      labelAlignment: ChartDataLabelAlignment.top),
                  name: 'Humidity (%)',
                  xValueMapper: (WeatherData weather, _) => weather.day,
                  yValueMapper: (WeatherData weather, _) => weather.humidity,
                )
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
      WeatherData(29, 14, 'Tue\n 12/2'),
      WeatherData(28, 18, 'Wed\n 13/2'),
      WeatherData(24, 16, 'Thur\n 14/2'),
      WeatherData(25, 17, 'Fri\n 15/2'),
      WeatherData(23, 15, 'Sat\n 16/2'),
    ];
    return weatherData;
  }
}

class WeatherData {
  WeatherData(this.temp, this.humidity, this.day);

  final double temp;
  final double humidity;
  final String day;
}
