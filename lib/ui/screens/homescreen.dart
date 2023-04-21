import 'dart:async';
import 'package:flutter/material.dart';
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
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue[800]!,
                  Colors.blue[600]!,
                ],
              ),
            ),
            height: 30.h,
            child: ListView(
              children: [
                Text(city['city'],
                    style: Theme.of(context).textTheme.titleLarge),
                SizedBox(height: 5.h),
                Text('Longitude: ${city['lng']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                Text('Latitude: ${city['lat']}',
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 5.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Get more info about the area ...',
                        style: Theme.of(context).textTheme.bodyMedium),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MoreInfo(city: city['city']),
                          ),
                        );
                      },
                      child: Text('More info',
                          style:
                              TextStyle(color: Colors.black, fontSize: 12.sp)),
                    ),
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
