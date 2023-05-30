import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sizer/sizer.dart';
import 'package:unrelo/ui/widgets/custom_container.dart';

class CurrentConditions extends StatelessWidget {
  const CurrentConditions(
      {super.key, required this.humidity, required this.temperature});

  final String humidity;
  final String temperature;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: 6.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Row(
          //   children: [
          //     SvgPicture.asset(
          //       'assets/images/soil_moisture.svg',
          //     ),
          //     SizedBox(width: 1.h),
          //     Text('30%', style: TextStyle(fontSize: 12.sp)),
          //   ],
          // ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/temp.svg',
              ),
              SizedBox(width: 1.h),
              Text('$temperature °C', style: TextStyle(fontSize: 12.sp)),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/humidity.svg',
              ),
              SizedBox(width: 1.h),
              Text('$humidity %', style: TextStyle(fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }
}
