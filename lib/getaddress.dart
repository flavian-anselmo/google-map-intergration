import 'package:geocoding/geocoding.dart';
import 'package:googlemaps/getlocation.dart';

class GetAddressThroughGeoCoding extends CheckLocationEnabled {
  //get the coordinates form the class tha handles that through inheritance
  late String currentAddress;
  void getAddressFromCoordinates(double lat, double long) async {
    //retrieve the address form the coordinates
    try {
      List<Placemark> address = await placemarkFromCoordinates(lat, long);
      //take the most probable result
      Placemark place = address[0];

      //address structure
      currentAddress =
          "${place.name},${place.locality},${place.street}${place.postalCode}";
      print(currentAddress);
    } catch (e) {
      print(e);
    }
  }
}
