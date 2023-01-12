import 'package:location/location.dart';

class LocationService {
  final Location _location = Location();

  Future<bool> _serviceEnabled() async {
    bool isEnabled = await _location.serviceEnabled();
    if (!isEnabled) {
      isEnabled = await _location.requestService();
    }
    return isEnabled;
  }

  Future<bool> _permissionGranted() async {
    bool isPermissionGranted = true;
    PermissionStatus status = await _location.hasPermission();
    isPermissionGranted = status == PermissionStatus.granted;
    if (!isPermissionGranted) {
      status = await _location.requestPermission();
      isPermissionGranted = status == PermissionStatus.granted;
    }
    return isPermissionGranted;
  }

  Future<LocationData?> getCurrentLocation() async {
    if (await _serviceEnabled()) {
      if (await _permissionGranted()) {
        return await _location.getLocation();
      }
    }
  }
}
