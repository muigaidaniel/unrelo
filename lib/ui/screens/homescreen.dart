// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sizer/sizer.dart';
import 'more_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.sensors}) : super(key: key);

  final List<Map<String, dynamic>> sensors;

  @override
  State<HomeScreen> createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  GoogleMapController? _mapController;
  Position? _userPosition;
  String? selectedSensor = 'Select Sensor';

  @override
  void initState() {
    super.initState();
    requestLocationPermission();
  }

  Future<void> requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      fetchUserLocation();
    }
  }

  Future<void> fetchUserLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _userPosition = position;
      });
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ),
      );
    } catch (error) {
      log(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        GoogleMap(
          onMapCreated: (GoogleMapController controller) {
            _mapController = controller;
            log(widget.sensors.toString());
          },
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: true,
          initialCameraPosition: CameraPosition(
            target: _userPosition != null
                ? LatLng(_userPosition!.latitude, _userPosition!.longitude)
                : const LatLng(-1.2864, 36.8172),
            zoom: 10.0,
          ),
          markers: Set.from(
            widget.sensors.map(
              (sensor) => Marker(
                markerId: MarkerId('${sensor['sensorId']}}'),
                position: LatLng(sensor['latitude']!, sensor['latitude']!),
                onTap: () => _showBottomSheet(context, sensor),
              ),
            ),
          ),
        ),
        Container(
          width: 80.w,
          height: 6.h,
          margin: EdgeInsets.only(top: 7.h),
          padding: EdgeInsets.symmetric(horizontal: 3.w),

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
          child: Row(
            children: [
              Icon(
                Icons.pin_drop,
                size: 15.sp,
              ),
              Expanded(
                child: DropdownButton(
                  underline: const SizedBox(),
                  isExpanded: true,
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_drop_down),
                  selectedItemBuilder: (BuildContext context) {
                    return widget.sensors.map<Widget>((dynamic item) {
                      return Center(
                        child: Text(
                          item['sensorName'],
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(fontSize: 11.sp, color: Colors.black),
                        ),
                      );
                    }).toList();
                  },
                  value: widget.sensors[1]['sensorName'],
                  items: widget.sensors
                      .map(
                        (sensor) => DropdownMenuItem(
                          value: sensor['sensorName'],
                          child: Text(
                            sensor['sensorName'],
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 11.sp, color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSensor = value.toString();
                      for (var sensor in widget.sensors) {
                        if (sensor['sensorName'] == value) {
                          _mapController!.animateCamera(
                            CameraUpdate.newLatLng(
                              LatLng(sensor['latitude']!, sensor['longitude']!),
                            ),
                          );
                        }
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          // child: Center(
          //     child: Text(
          //   '${widget.sensors.length} sensors found',
          //   style: TextStyle(fontSize: 11.sp, color: Colors.black),
          // )),
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
                Text(city['sensorName'],
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
