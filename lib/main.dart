import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.cyan,


          ),
          home: Homepage()


      )
  );
}


class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  Position position;
  StreamSubscription<Position> positionStream;
  String lat,long = '';





  getLocation () async {
    var geolocator = Geolocator();
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);

    positionStream = geolocator.getPositionStream(locationOptions).listen(
            (Position position) {
          // print(position == null ? 'Unknown' : position.latitude.toString() + ', ' + position.longitude.toString());
          if(position != null){
            setState(() {
              lat = position.latitude.toString();
              long = position.longitude.toString();
            });
          }
          else{
            setState(() {
              lat = 'Unassigned';
              long = 'Unassigned';
            });
          }
        });

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat='Unassigned';
    long='Unassigned';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS App'),
        centerTitle: true,

      ),

      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              SizedBox(height: 60),
              Text(lat,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                child: Text("Latitude",style: TextStyle(fontSize: 40),),
              ),
              Divider(thickness: 5,color: Colors.cyanAccent,),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 5),
                child: Text(long,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              ),
              Text("Longtitude",style: TextStyle(fontSize: 40),),
              Padding(
                padding: const EdgeInsets.all(40),
                child: RaisedButton(
                  onPressed: getLocation,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                    child: Text('Measure',style: TextStyle(color: Colors.black,fontSize: 25)),
                  )
                  ,color: Theme.of(context).primaryColor,),
              )
            ],
          ),
        ),
      ),


    );
  }
}
