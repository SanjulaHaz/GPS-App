import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.greenAccent,),
          home: Homepage()
      )
  );
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  var loc1,loc2,loc3,loc4,loc5,loc6;
  String lat, long;
  getLocation() async {
    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    if(position != null){
      setState(() {
        lat = position.latitude.toString();
        long = position.longitude.toString();
      });
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(position.latitude, position.longitude);
      setState(() {
        loc1 = placemark[0].name;
        loc2 = placemark[0].subLocality;
        loc3 = placemark[0].locality;
        loc4 = placemark[0].subAdministrativeArea;
        loc5 = placemark[0].administrativeArea;
        loc6 = placemark[0].country;
      });
    }
    else{
      setState(() {
        lat = 'N/A';
        long = 'N/A';
      });
    }

  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    lat='N/A';
    long='N/A';
    loc1='N/A';
    loc2='N/A';
    loc3='N/A';
    loc4='N/A';
    loc5='N/A';
    loc6='N/A';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPS App',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        elevation: 0,
      ),

      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 60),
                Text(lat,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Latitude",style: TextStyle(fontSize: 20),),
                ),
                Text(long,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Longitude",style: TextStyle(fontSize: 20),),
                ),
                Text(loc1,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Placemark",style: TextStyle(fontSize: 20),),
                ),
                Text(loc2,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Sub Locality",style: TextStyle(fontSize: 20),),
                ),
                Text(loc3,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Locality",style: TextStyle(fontSize: 20),),
                ),
                Text(loc4,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Sub Administrative Area",style: TextStyle(fontSize: 20),),
                ),
                Text(loc5,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Administrative Area",style: TextStyle(fontSize: 20),),
                ),
                Text(loc6,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),textAlign: TextAlign.center),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 30),
                  child: Text("Country",style: TextStyle(fontSize: 20),),
                ),
                Padding(
                  padding: const EdgeInsets.all(40),
                  child: RaisedButton(
                    onPressed: getLocation,
                    child: Text('Measure',style: TextStyle(color: Colors.white,fontSize: 25)),
                    color: Colors.green,
                    splashColor: Colors.red,
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
