import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class StorageService {
  // Get an instance of Firestore
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addUser(
      String userName, String phoneNumber, String email) async {
    try {
      DocumentReference userRef = firestore.collection('users').doc();

      Map<String, dynamic> userData = {
        'userId': userRef.id,
        'userName': userName,
        'phoneNumber': phoneNumber,
        'email': email,
      };

      await userRef.set(userData);
    } catch (error) {
      log('Error storing user data: $error');
    }
  }

  Future<List<Map<String, dynamic>>> fetchSensorList() async {
    try {
      CollectionReference sensorsRef =
          FirebaseFirestore.instance.collection('sensors');
      QuerySnapshot snapshot = await sensorsRef.get();

      List<Map<String, dynamic>> sensorList = [];

      for (QueryDocumentSnapshot doc in snapshot.docs) {
        String sensorId = doc['sensor_id'] as String;
        String sensorName = doc['sensor_name'] as String;
        GeoPoint location = doc['sensor_location'] as GeoPoint;

        double latitude = location.latitude;
        double longitude = location.longitude;

        Map<String, dynamic> sensorData = {
          'sensorId': sensorId,
          'sensorName': sensorName,
          'latitude': latitude,
          'longitude': longitude,
        };

        sensorList.add(sensorData);
      }
      return sensorList;
    } catch (error) {
      log('Error fetching sensor list: $error');
      return [];
    }
  }
}
