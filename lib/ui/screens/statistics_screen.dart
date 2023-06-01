import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/widgets/forecast_chart.dart';
import 'package:unrelo/ui/widgets/statistics_chart.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen(
      {super.key, required this.dailyData, required this.predictions});

  final Map<String, dynamic> dailyData;
  final List predictions;

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
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('daily_readings')
                  .where('sensor_id',
                      isEqualTo: int.parse(widget.dailyData['sensorId']))
                  //.orderBy('timestampUtc', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData) {
                  return const Center(child: Text('No data available'));
                }
                List<Map<String, dynamic>> readingsDataList = snapshot
                    .data!.docs
                    .map((DocumentSnapshot doc) =>
                        doc.data() as Map<String, dynamic>)
                    .toList();

                double sum = 0.0;
                for (var data in readingsDataList) {
                  double avgTemp = data['daily_avg_temp'];
                  sum += avgTemp;
                }
                double averageTemp = sum / readingsDataList.length;

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('This month\'s statistics',
                          style:
                              TextStyle(color: Colors.white, fontSize: 12.sp)),
                      Text(
                          'Average: ${averageTemp.toString().substring(0, 4)} °C',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold)),
                      StatisticsChart(data: readingsDataList),
                      SizedBox(height: 3.h),
                      ForecastChart(predictions: widget.predictions)
                    ],
                  ),
                );
              }),
        ));
  }
}
