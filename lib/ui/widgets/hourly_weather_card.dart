import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

class HourlyCard extends StatelessWidget {
  const HourlyCard(
      {super.key,
      required this.temperature,
      required this.time,
      required this.humidity,
      required this.icon});
  final String temperature;
  final String time;
  final String icon;
  final String humidity;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(time, style: TextStyle(fontSize: 12.sp)),
          SizedBox(height: 1.h),
          SizedBox(
            height: 30.sp,
            child: SvgPicture.asset(
              'assets/images/$icon.svg',
            ),
          ),
          Text(temperature, style: TextStyle(fontSize: 12.sp)),
          Text(humidity, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
