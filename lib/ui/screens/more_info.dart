import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/widgets/current_conditions.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';
import 'package:unrelo/ui/widgets/daily_weather_card.dart';
import 'package:unrelo/ui/widgets/hourly_weather_card.dart';

class MoreInfo extends StatelessWidget {
  const MoreInfo({super.key, required this.prev});
  final Map<String, dynamic> prev;

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
                Map<String, dynamic> lastData = readingsDataList[0];

                double humidity = double.parse(
                        lastData['avgHumidity'].toString().substring(0, 5)) *
                    100;

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
                            '${lastData['avgTemp'].toString().substring(0, 5)} °C',
                            //'${prev['avgTemp'].toString().substring(0, 5)} °C',
                            style: TextStyle(
                                fontSize: 30.sp, fontWeight: FontWeight.bold)),
                        SizedBox(height: 1.h),
                        Text('Temperature', style: TextStyle(fontSize: 12.sp)),
                        SizedBox(height: 1.h),
                        Text('Max: 28°C    Min 20°C',
                            style: TextStyle(fontSize: 12.sp)),
                        GestureDetector(
                          onTap: () {
                            log(readingsDataList.toString());
                          },
                          child: CurrentConditions(
                            temperature:
                                lastData['avgTemp'].toString().substring(0, 5),
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
                                      Text('Mar, 9',
                                          style: TextStyle(fontSize: 14.sp)),
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    HourlyCard(
                                      temperature: '29°C',
                                      time: '15.00',
                                      icon: 'sunnycloudy',
                                    ),
                                    HourlyCard(
                                      temperature: '26°C',
                                      time: '16.00',
                                      icon: 'cloudy',
                                    ),
                                    HourlyCard(
                                      temperature: '24°C',
                                      time: '17.00',
                                      icon: 'sunnycloudy',
                                    ),
                                    HourlyCard(
                                      temperature: '23°C',
                                      time: '18.00',
                                      icon: 'cloudy',
                                    ),
                                    HourlyCard(
                                      temperature: '28°C',
                                      time: '19.00',
                                      icon: 'cloudynight',
                                    )
                                  ],
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
                                      onPressed: () => Navigator.pushNamed(
                                          context, '/statistics'),
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
                                child: ListView(
                                  children: const [
                                    DailyCard(
                                        day: 'Monday',
                                        icon: 'sunnycloudy',
                                        temp: '13°C',
                                        humidity: '20%'),
                                    DailyCard(
                                        day: 'Tuesday',
                                        icon: 'sunnycloudy',
                                        temp: '13°C',
                                        humidity: '20%'),
                                    DailyCard(
                                        day: 'Wednesday',
                                        icon: 'sunnycloudy',
                                        temp: '13°C',
                                        humidity: '20%'),
                                    DailyCard(
                                        day: 'Thursday',
                                        icon: 'sunnycloudy',
                                        temp: '13°C',
                                        humidity: '20%'),
                                    DailyCard(
                                        day: 'Friday',
                                        icon: 'sunnycloudy',
                                        temp: '13°C',
                                        humidity: '20%'),
                                  ],
                                ),
                              )
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
}
