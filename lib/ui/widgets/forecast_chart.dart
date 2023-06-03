import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';

class ForecastChart extends StatefulWidget {
  const ForecastChart({super.key, required this.predictions});

  final List predictions;

  @override
  State<ForecastChart> createState() => _ForecastChartState();
}

class _ForecastChartState extends State<ForecastChart> {
  late List<WeatherData> weatherData;
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    weatherData = getData(widget.predictions);
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
                  majorGridLines: const MajorGridLines(width: 0),
                  isVisible: false),
            ),
          ),
        ],
      ),
    );
  }

  List<WeatherData> getData(predictions) {
    List<WeatherData> weatherDataList = [];
    for (int i = 0; i < predictions.length; i++) {
      var data = predictions[i];
      int temperature = data['avg_temp'].round();
      int humidity = (data['avg_humidity'] * 100).round();
      int index = i + 1;

      WeatherData weatherData =
          WeatherData(temperature, humidity, "Day $index");
      weatherDataList.add(weatherData);
    }
    return weatherDataList;
  }
}

class WeatherData {
  WeatherData(this.temp, this.humidity, this.day);

  final int temp;
  final int humidity;
  final String day;
}
