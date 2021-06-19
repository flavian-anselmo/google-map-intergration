/// @anselmo-flavian
/// google map intergration in flutter apps
/// simulation how it works 
import 'package:flutter/material.dart';
import 'package:googlemaps/mapscreen.dart';
void main() {
  runApp(GoogleMapIntergrationFlutter());
}

class GoogleMapIntergrationFlutter extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'GoogleMaps',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      ///MOVE TO THE SCREEN WHERE THE MAP IS INTERGRATED 
     home: MapScreenfromGoogle(),
    );
  }
}
