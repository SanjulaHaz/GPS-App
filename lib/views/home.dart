import 'package:codein_gps/widgets/tile.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String? loc1, loc2, loc3, loc4, loc5, loc6;
  String lat = 'N/A', long = 'N/A';

  void getLocation() async {
    Position position =
        await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    setState(() {
      lat = position.latitude.toString();
      long = position.longitude.toString();
    });
    List<Placemark> placeMark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    setState(() {
      loc1 = placeMark[0].name;
      loc2 = placeMark[0].subLocality;
      loc3 = placeMark[0].locality;
      loc4 = placeMark[0].subAdministrativeArea;
      loc5 = placeMark[0].administrativeArea;
      loc6 = placeMark[0].country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GPS App',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60),
                Tile(value: lat, title: "Latitude"),
                Tile(value: long, title: "Longitude"),
                Tile(value: loc1, title: "Placemark"),
                Tile(value: loc2, title: "Sub Locality"),
                Tile(value: loc3, title: "Locality"),
                Tile(value: loc4, title: "Sub Administrative Area"),
                Tile(value: loc5, title: "Administrative Area"),
                Tile(value: loc6, title: "Country"),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: ElevatedButton(
                    onPressed: getLocation,
                    child: Text(
                      'Measure',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
