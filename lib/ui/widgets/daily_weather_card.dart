import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class DailyCard extends StatelessWidget {
  const DailyCard(
      {super.key,
      required this.day,
      required this.icon,
      required this.temp,
      required this.humidity});
  final String day;
  final String icon;
  final String temp;
  final String humidity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 70.sp,
            child: Text(day,
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)),
          ),
          SvgPicture.asset('assets/images/$icon.svg'),
          Text(temp, style: TextStyle(fontSize: 12.sp)),
          Text(humidity, style: TextStyle(fontSize: 12.sp)),
        ],
      ),
    );
  }
}
