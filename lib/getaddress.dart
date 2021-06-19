import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/getlocation.dart';
import 'package:googlemaps/mapscreen.dart';

class GetAddressThroughGeoCoding extends CheckLocationEnabled {
  //get the coordinates form the class tha handles that through inheritance
  late String currentAddress;
  late String destinationAddress;
  late double startLattitude;
  late double startLongitude;
  late double destLattitude;
  late double destLongitude;
  late String startCoordinatesString;
  late String destinationCoordinatesString;
  Future<void> getAddressFromCoordinates(double lat, double long) async {
    //retrieve the address form the coordinates
    try {
      List<Placemark> address = await placemarkFromCoordinates(lat, long);
      //take the most probable result
      Placemark place = address[0];

      //address structure
      currentAddress =
          "${place.name},${place.locality},${place.subAdministrativeArea}";

      print(currentAddress);
      //SET THE CURRENT ADREESS
      startAddressController.text = currentAddress;
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCoordinatesFromAnGeocodedAddress() async {
    ///you can use a similar method to retrive the coordinates
    ///from the starting address and the destination address
    ///you need these coordinates to draw a route on the map and to place markers
    List<Location> startPlaceMark = await locationFromAddress(currentAddress);
    List<Location> destinationPlaceMark =
        await locationFromAddress(destinationAddress);

    ///store the longitudes and the lattitudes
    startLattitude = startPlaceMark[0].latitude;
    startLongitude = startPlaceMark[0].longitude;
    destLattitude = destinationPlaceMark[0].latitude;
    destLongitude = destinationPlaceMark[0].longitude;

    startCoordinatesString = '($startLattitude, $startLongitude)';
    destinationCoordinatesString = '($destLattitude, $destLongitude)';
  }
}

class CreateMarkers {
  Marker startPositionMarker = Marker(
    markerId: MarkerId(geocodeAddress.startCoordinatesString),
    position:
        LatLng(geocodeAddress.startLattitude, geocodeAddress.startLongitude),
    infoWindow: InfoWindow(
      title: 'Start ${geocodeAddress.startCoordinatesString}',
      snippet: geocodeAddress.currentAddress,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  //this is the marker for  the destination area
  Marker destinationPositionMarker = Marker(
    markerId: MarkerId(geocodeAddress.destinationCoordinatesString),
    position: LatLng(
      geocodeAddress.destLattitude,
      geocodeAddress.destLongitude,
    ),
    infoWindow: InfoWindow(
      title: 'Destination ${geocodeAddress.destinationCoordinatesString}',
      snippet: geocodeAddress.destinationAddress,
    ),
    icon: BitmapDescriptor.defaultMarker,
  );

  ///addthe members of the markers to the list
}
