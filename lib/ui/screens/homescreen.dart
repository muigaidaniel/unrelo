import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import '../../models/cities.dart';
import 'more_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(-1.286389, 36.817223),
            zoom: 10.0,
          ),
          markers: Set.from(
            cities.map(
              (city) => Marker(
                markerId: MarkerId('${city['city']}}'),
                position: LatLng(
                    double.parse(city['lat']!), double.parse(city['lng']!)),
                onTap: () => _showBottomSheet(context, city),
              ),
            ),
          ),
        ),
        Container(
          width: 80.w,
          height: 5.h,
          margin: EdgeInsets.only(top: 7.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Center(
              child: Text(
            '${cities.length} sensors found',
            style: TextStyle(fontSize: 11.sp, color: Colors.black),
          )),
        ),
      ]),
    );
  }

  void _showBottomSheet(BuildContext context, Map<String, dynamic> city) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color(0xFF0B42AB),
            ),
            height: 40.h,
            child: ListView(
              children: [
                Text(city['city'],
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 3.h),
                Container(
                  height: 5.h,
                  //: Colors.red,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Temperature 10°C',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                          width: 20.sp,
                          child: SvgPicture.asset('assets/images/sun.svg'))
                    ],
                  ),
                ),
                Container(
                  height: 5.h,
                  //color: Colors.amber,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Humidity 10%',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                          width: 20.sp,
                          child: SvgPicture.asset('assets/images/fog.svg'))
                    ],
                  ),
                ),
                Container(
                  height: 5.h,
                  //color: Colors.green,
                  margin: EdgeInsets.only(top: 5.sp),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Soil moisture 10%',
                          style: Theme.of(context).textTheme.bodyLarge),
                      SizedBox(
                          width: 20.sp,
                          child: SvgPicture.asset('assets/images/rain.svg'))
                    ],
                  ),
                ),
                // Text('Longitude: ${city['lng']}',
                //     style: Theme.of(context).textTheme.bodyMedium),
                // Text('Latitude: ${city['lat']}',
                //     style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 4.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Get more info about the area ...',
                        style: Theme.of(context).textTheme.bodyMedium),
                    OutlinedButton(
                        // style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.white),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  MoreInfo(city: city['city']),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                            side:
                                const BorderSide(color: Colors.white, width: 1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text('More info',
                            style: TextStyle(
                                fontSize: 12.sp, color: Colors.white))),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
