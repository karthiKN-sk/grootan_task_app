// ignore_for_file: use_build_context_synchronously, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../../app/utils/reusable.dart';

class LocationController extends GetxController {
  ///
  String _currentAddress = "";
  String get currentAddress => _currentAddress;

  ///

  var _currentPosition;
  Position get currentPosition => _currentPosition;

  ///
  ///
  Future<String> getCurrentPosition(BuildContext context) async {
    final hasPermission = await _handleLocationPermission(context);

    if (hasPermission) {
      try {
        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        return await _getAddressFromLatLng(position);
      } catch (e) {
        debugPrint(e.toString());
        return e.toString();
      }
    }
    return _currentAddress;
  }

  ///
  Future<bool> _handleLocationPermission(BuildContext context) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isErrorSnackBar(context,
          message:
              'Location services are disabled. Please enable the services');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        isErrorSnackBar(context, message: 'Location permissions are denied');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      isErrorSnackBar(context,
          message:
              'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }

  Future<String> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      debugPrint(place.toString());
      debugPrint(place.toString());
      _currentAddress =
          '${place.subLocality}, ${place.locality}, ${place.country}, ${place.postalCode}';
      update();
      return _currentAddress;
    }).catchError((e) {
      debugPrint(e);
      return e.toString();
    });
    return _currentAddress;
  }
}
