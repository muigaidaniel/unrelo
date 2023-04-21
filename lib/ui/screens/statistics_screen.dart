import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/widgets/forecast_chart.dart';
import 'package:unrelo/ui/widgets/statistics_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF08244F),
              Color(0xFF134CB5),
              Color(0xFF0B42AB),
            ],
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Text('This year\'s statistics',
                    style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                Text('Average: 20.5°C',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold)),
                const StatisticsChart(),
                SizedBox(height: 3.h),
                const ForecastChart()
              ],
            ),
          ),
        ));
  }
}
