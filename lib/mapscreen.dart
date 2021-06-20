import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/components/constants.dart';
import 'package:googlemaps/components/reusablemapbtns.dart';
import 'package:googlemaps/getaddress.dart';
import 'package:googlemaps/getlocation.dart';

//TEXT FIELD CONTROLLER
final startAddressController = TextEditingController();

GetAddressThroughGeoCoding geocodeAddress = GetAddressThroughGeoCoding();

class MapScreenfromGoogle extends StatefulWidget {
  MapScreenfromGoogle({Key? key}) : super(key: key);

  @override
  _MapScreenfromGoogleState createState() => _MapScreenfromGoogleState();
}

class _MapScreenfromGoogleState extends State<MapScreenfromGoogle> {
  final _globalFormKey = GlobalKey<FormState>();
  //location instance
  CheckLocationEnabled loc = new CheckLocationEnabled();
  //this are the location coordinates
  Set<Marker> areaMarkers = {}; //will store our markers
  CreateMarkers storeMarkers = CreateMarkers();
  static double lat = 0.0;
  static double long = 0.0;
  @override
  void initState() {
    super.initState();
    //get the location of the user as the application loads
    setState(() {
      getLocation();
    });
  }

  //camera position in relation to the coordinates
  static final CameraPosition _deviceLocation =
      CameraPosition(target: LatLng(lat, long));
  late GoogleMapController mapController; //controller

  Future<void> getLocation() async {
    //get the current location of the user
    await loc.determineDeviceposition();
    setState(() {
      //this is the location of the user
      //the device location
      //gotten dynamically once the apploads
      //using the exact coordinates
      lat = CheckLocationEnabled.lattitude;
      long = CheckLocationEnabled.longitude;
      geocodeAddress.getAddressFromCoordinates(lat, long);
      //set the text name to the current location
      //startAddressController.text = a.currentAddress;
      areaMarkers.add(storeMarkers.startPositionMarker);
      areaMarkers.add(storeMarkers.destinationPositionMarker);

      ///MOVES THE MAP DIRECTLY TO YOUR LOCATION AS THE APP LOADS
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            //move to the fetched coordinates
            //this will zoom the map to the exact location
            //of the device
            target: LatLng(
              lat,
              long,
            ),
            zoom: 15.0,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    ///defined a container height and width to be the size of the screen
    ///so that the google maps widget takes up the entire screen
    ///iam also using stack to keep google maps in the backgroung and
    ///add thoer necessary widgets on top of it

    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Container(
        height: height,
        width: width,
        child: Scaffold(
          ///PLACE THE GOOGLE MAPS WIDGET HERE
          ///THIS WILL DISPLAY THE LOCATION
          body: Stack(
            children: <Widget>[
              GoogleMap(
                //get the device location using the coordinates
                initialCameraPosition: _deviceLocation,
                mapType: MapType.normal,
                //myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                //display the markers
                //from our set of markers
                markers: Set<Marker>.from(areaMarkers),
                //this is the controler for the map on the screen
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
              ),

              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Form(
                  key: _globalFormKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: startAddressController,
                        decoration: kinputDecoration,
                        //initialValue:a.currentAddress,
                        onChanged: (value) {
                          //todo pick the user inputs to create routes and distance
                          //this is where the user will input the start adress
                          geocodeAddress.currentAddress = value;
                        },
                      ),
                      SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                        //controller: startAddressController,
                        decoration: kinputDecoration,
                        //initialValue:startAddressController.text,
                        onChanged: (value) {
                          //todo pick the user inputs to create routes and distance
                          //this where the user will input the destination address
                          geocodeAddress.destinationAddress = value;
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          elevation: 5.0,
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(30.0),
                          child: MaterialButton(
                            onPressed: () {
                              //create routes and displaye the maekers
                              setState(() {
                                geocodeAddress
                                    .getCoordinatesFromAnGeocodedAddress();
                                //SET THE MARKERS HERE
                                //store the markers in the set of markers
                                //display the makrkers in the google map widget
                              });
                            },
                            minWidth: 200.0,
                            height: 42.0,
                            child: Text(
                              'Get route',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              ///button ui imlimentation
              ///how the buttoon will look
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 0, 50),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ReusableMapButtons(
                      icontype: Icons.my_location,
                      onTap: () {
                        //todo implement the logic of the button
                        //MOVE THE CAMERA TO THE SPECIFIED lat and long position
                        mapController.animateCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              //move to the fetched coordinates
                              //this will zoom the map to the exact location
                              //of the device
                              target: LatLng(
                                lat,
                                long,
                              ),
                              zoom: 20.0,
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ReusableMapButtons(
                      icontype: Icons.zoom_in,
                      onTap: () {
                        //todo implement the logic of the button
                        //will allow the user to zoom in
                        mapController.animateCamera(CameraUpdate.zoomIn());
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    ReusableMapButtons(
                      icontype: Icons.zoom_out,
                      onTap: () {
                        //todo implement the logic of the button
                        //allow the user to zoom out of the map
                        mapController.animateCamera(CameraUpdate.zoomOut());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
