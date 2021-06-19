import 'package:geocoding/geocoding.dart';
import 'package:googlemaps/getlocation.dart';
import 'package:googlemaps/mapscreen.dart';

class GetAddressThroughGeoCoding extends CheckLocationEnabled {
  //get the coordinates form the class tha handles that through inheritance
  late String currentAddress;
  late String destinationAddress;
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

  Future<void> getCoordinatesFromAnGeocodedAddress(
    ) async {
    ///you can use a similar method to retrive the coordinates
    ///from the starting address and the destination address
    ///you need these coordinates to draw a route on the map and to place markers
    List<Location> startPlaceMark = await locationFromAddress(currentAddress);
    List<Location> destinationPlaceMark =
        await locationFromAddress(destinationAddress);

    ///store the longitudes and the lattitudes
    double startLattitude = startPlaceMark[0].latitude;
    double startLongitude = startPlaceMark[0].longitude;
    double destLattitude = destinationPlaceMark[0].latitude;
    double destLongitude = destinationPlaceMark[0].longitude;
  }
}
