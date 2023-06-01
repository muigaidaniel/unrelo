import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StatisticsChart extends StatefulWidget {
  const StatisticsChart({super.key, required this.data});
  final List<Map<String, dynamic>> data;

  @override
  State<StatisticsChart> createState() => _StatisticsChartState();
}

class _StatisticsChartState extends State<StatisticsChart> {
  late List<WeatherData> weatherData;
  late TooltipBehavior tooltipBehavior;

  @override
  void initState() {
    weatherData = generateWeatherDataList(widget.data);
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
            majorGridLines: const MajorGridLines(width: 0),
            majorTickLines: const MajorTickLines(size: 0),
            labelStyle: const TextStyle(
              color: Colors.white,
            )),
      ),
    );
  }

  List<WeatherData> generateWeatherDataList(
      List<Map<String, dynamic>> dataList) {
    List<WeatherData> weatherDataList = [];

    for (var data in dataList) {
      int timestampUtc = data['timestampUtc'];
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestampUtc);
      String date = dateTime.toString().split(' ')[0];
      String dayOfMonth = date.split('-')[2];
      double dailyAvgTemp = data['daily_avg_temp'];
      double dailyAvgHumidity = data['daily_avg_humidity'] * 100;

      WeatherData weatherData = WeatherData(
          dayOfMonth,
          int.parse(dailyAvgTemp.toString().split('.')[0]),
          int.parse(dailyAvgHumidity.toString().split('.')[0]));
      weatherDataList.add(weatherData);
    }

    weatherDataList.sort((a, b) => a.month.compareTo(b.month));
    // Sorts the weatherDataList based on the dayOfMonth (date) in ascending order

    return weatherDataList;
  }
}

class WeatherData {
  WeatherData(this.month, this.temp, this.humidity);

  final String month;
  final int temp;
  final int humidity;
}
