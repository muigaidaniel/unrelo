import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';

class CurrentConditions extends StatelessWidget {
  const CurrentConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/soil_moisture.svg',
            ),
            SizedBox(width: 1.h),
            Text('30%', style: TextStyle(fontSize: 12.sp)),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/temp.svg',
            ),
            SizedBox(width: 1.h),
            Text('30%', style: TextStyle(fontSize: 12.sp)),
          ],
        ),
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/humidity.svg',
            ),
            SizedBox(width: 1.h),
            Text('10%', style: TextStyle(fontSize: 12.sp)),
          ],
        ),
      ],
    );
  }
}
