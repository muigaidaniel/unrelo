import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/screens/statistics_screen.dart';
import 'package:unrelo/ui/widgets/current_conditions.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';
import 'package:unrelo/ui/widgets/daily_weather_card.dart';
import 'package:unrelo/ui/widgets/hourly_weather_card.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key, required this.prev, required this.predictions});
  final Map<String, dynamic> prev;
  final List predictions;

  @override
  Widget build(BuildContext context) {
    DateTime currentTime = DateTime(2022, 12, 31, 23, 0);
    DateTime twentyFourHoursAgo =
        currentTime.subtract(const Duration(hours: 24));
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
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                onPressed: () {},
              ),
            ],
            title: Text(prev['sensorName'].toString().split(' ')[0],
                style: Theme.of(context).textTheme.bodyLarge),
          ),
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('readings')
                  .where('sensorId', isEqualTo: int.parse(prev['sensorId']))
                  .where('timestampUtc',
                      isGreaterThan: twentyFourHoursAgo.toIso8601String())
                  .orderBy('timestampUtc', descending: true)
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

                List<Map<String, dynamic>> lastFiveRecords =
                    readingsDataList.reversed.toList();
                List<HourlyCard> hourlyCards = lastFiveRecords.map((record) {
                  double temperature = record['avgTemp'];
                  double humidity = record['avgHumidity'] * 100;
                  String time =
                      record['timestampUtc'].toString().substring(11, 16);
                  String icon = 'sunnycloudy';

                  return HourlyCard(
                    temperature: '${temperature.toString().split('.')[0]}°C',
                    humidity: '${humidity.toString().substring(0, 2)} %',
                    time: time,
                    icon: icon,
                  );
                }).toList();
                double maxTemp = double.negativeInfinity;
                double minTemp = double.infinity;

                for (var readingData in readingsDataList) {
                  double avgTemp = readingData['avgTemp'];

                  if (avgTemp > maxTemp) {
                    maxTemp = avgTemp;
                  }

                  if (avgTemp < minTemp) {
                    minTemp = avgTemp;
                  }
                }
                Map<String, dynamic> lastData = readingsDataList[0];

                double humidity = double.parse(
                        lastData['avgHumidity'].toString().substring(0, 5)) *
                    100;
                DateTime dateTime = DateTime.parse(lastData['timestampUtc']);
                String today = DateFormat('MMM, d').format(dateTime);

                return Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          height: 23.h,
                          child: Image.asset('assets/images/rainsunny_2.png'),
                        ),
                        Text(
                            '${lastData['avgTemp'].toString().split('.')[0]}°C',
                            //'${prev['avgTemp'].toString().substring(0, 5)} °C',
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 1.h),
                        Text('Temperature', style: TextStyle(fontSize: 12.sp)),
                        SizedBox(height: 1.h),
                        Text(
                            'Max: ${maxTemp.toString().split('.')[0]} °C    Min ${minTemp.toString().split('.')[0]} °C',
                            style: TextStyle(fontSize: 12.sp)),
                        GestureDetector(
                          onTap: () {
                            print(predictions);
                          },
                          child: CurrentConditions(
                            temperature:
                                lastData['avgTemp'].toString().substring(0, 4),
                            humidity: humidity.toString(),
                          ),
                        ),
                        CustomContainer(
                            height: 22.h,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 2.h),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(left: 3.w),
                                        child: Text('Today',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      Text(today,
                                          style: TextStyle(fontSize: 14.sp)),
                                    ],
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      for (var i = 0;
                                          i < hourlyCards.length;
                                          i++)
                                        hourlyCards[i],
                                    ],
                                  ),
                                )
                              ],
                            )),
                        CustomContainer(
                          height: 29.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('5 Day Forecast',
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold)),
                                  OutlinedButton(
                                      onPressed: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  StatisticsScreen(
                                                      predictions: predictions,
                                                      dailyData: prev))),
                                      style: OutlinedButton.styleFrom(
                                          side: const BorderSide(
                                              color: Colors.white, width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10))),
                                      child: Text('View Stats',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.white)))
                                ],
                              ),
                              SizedBox(height: 1.h),
                              SizedBox(
                                  height: 16.h,
                                  child: ListView.builder(
                                    itemCount: predictions.length,
                                    itemBuilder: (context, index) {
                                      Map<String, dynamic> data =
                                          predictions[index];
                                      String day = getDayOfWeek(index + 1);
                                      String icon = 'sunnycloudy';
                                      String temp = data["avg_temp"]
                                          .toString()
                                          .split('.')[0];
                                      String humidity =
                                          (data["avg_humidity"] * 100)
                                              .toString()
                                              .split('.')[0];

                                      return DailyCard(
                                        day: day,
                                        icon: icon,
                                        temp: '$temp °C',
                                        humidity: '$humidity %',
                                      );
                                    },
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ));
  }

  String getDayOfWeek(int dayIndex) {
    switch (dayIndex) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}
