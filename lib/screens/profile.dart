import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:geolocator/geolocator.dart';
import 'package:queue_client/models/entity.dart';
import 'package:redux/redux.dart';

class ProfileScreen extends StatelessWidget {
  // final String name;
  // final String phoneNumber;

  // ProfileScreen({required this.name, required this.phoneNumber});

  String _getInitials(name) {
    List<String> nameSplit = name.split(" ");
    String initials = "";

    if (nameSplit.length > 1) {
      initials = nameSplit[0][0] + nameSplit[1][0];
    } else {
      initials = nameSplit[0][0];
    }

    return initials.toUpperCase();
  }

  void getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled, handle accordingly
      return;
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Location permissions are denied, handle accordingly
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Location permissions are permanently denied, handle accordingly
      return;
    }

    // Get the current position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Retrieve the latitude and longitude
    double latitude = position.latitude;
    double longitude = position.longitude;

    // Use the location data as needed
    print('Latitude: $latitude, Longitude: $longitude');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.all(20),
        child: StoreConnector<Entity, Entity>(
          converter: (Store<Entity> store) {
            return store.state;
          },
          builder: (BuildContext context, Entity entity) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8.0,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      _getInitials(entity.name),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  entity.name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8.0),
                Text(
                  entity.phoneNumber!,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                ElevatedButton(
                    onPressed: () {
                      getCurrentLocation();
                    },
                    child: Text("Getlocation")),
                SizedBox(height: 8.0),
                Text(
                  "location",
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
