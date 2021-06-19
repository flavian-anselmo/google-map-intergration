///get the current location of the user
///the location generated has the longitude and lattitude of the user
import 'package:geolocator/geolocator.dart';

class CheckLocationEnabled {
  //check if the user has enabled the location in their app
  ///determine the current position of the device
  ///when the location services are not enabled or permission
  ///are denied the future will return an error
  static double longitude = 0.0;
  static double lattitude = 0.0;
  late bool _isServiceEnabled;
  late LocationPermission _permission;

  Future<void> determineDeviceposition() async {
    //this operation is done asynchronously

    ///check if location services are enabled
    _isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    try {
      if (!_isServiceEnabled) {
        ///this means the location services are not enabled in the phone
        ///make the user enable the srevices
        print('Location Permission denied');
        _goToAppSettings();
      }
    } catch (e) {
      print(e);
    }
    _permission = await Geolocator.checkPermission();
    _checkForDeniedpermission();
    try {
      if (_isServiceEnabled = true) {
        //get thelongitudinal and lattitudinal locations
        //the dependancy accuracy can be high low best etc
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);

        ///get the location coodinates
        ///they are of type double
        ///

        longitude = position.longitude;
        lattitude = position.latitude;
        print(position.latitude);
        print(position.longitude);
      }
    } catch (e) {
      //print an error incase anything occurs
      //during fetch of the coordinates
      print(e);
    }
  }

  //allow the user to go to app settings if the location services are not enabled
  Future<void> _goToAppSettings() async {
    //Force the user to switch on location
    try {
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    } catch (e) {
      print(e);
    }
  }

  Future<void> _checkForDeniedpermission() async {
    try {
      if (_permission == LocationPermission.denied) {
        ///retry to request permisssion
        _permission = await Geolocator.requestPermission();

        print('Kindly allow the location services');
      }
    } catch (e) {
      print(e);
    }
  }
}