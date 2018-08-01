import 'dart:async';

import 'package:flutter/services.dart';

class Permission {
  static const MethodChannel _channel = const MethodChannel('plugins.ly.com/permission');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<PermissionStatus>> getPermissionStatus(List<Permissions> permissions) async {
    List<String> list = [];
    permissions.forEach((p) {
      list.add(getPermissionString(p));
    });
    final List<int> status = await _channel.invokeMethod("getPermissionStatus", {"permissions": list});
    List<PermissionStatus> permissionStatusList = [];
    status.forEach((i){
      switch (i) {
        case -1:
          permissionStatusList.add(PermissionStatus.notAgain);
          break;
        case 0:
          permissionStatusList.add(PermissionStatus.deny);
          break;
        case 1:
          permissionStatusList.add(PermissionStatus.allow);
          break;
        default:
          permissionStatusList.add(PermissionStatus.deny);
          break;
      }
    });
    return permissionStatusList;
  }

  static Future<List<PermissionStatus>> requestPermission(List<Permissions> permissions) async {
    List<String> list = [];
    permissions.forEach((p) {
      list.add(getPermissionString(p));
    });
    final List<int> status = await _channel.invokeMethod("requestPermission", {"permissions": list});
    List<PermissionStatus> permissionStatusList = [];
    status.forEach((i){
      switch (i) {
        case -1:
          permissionStatusList.add(PermissionStatus.notAgain);
          break;
        case 0:
          permissionStatusList.add(PermissionStatus.deny);
          break;
        case 1:
          permissionStatusList.add(PermissionStatus.allow);
          break;
        default:
          permissionStatusList.add(PermissionStatus.deny);
          break;
      }
    });
    return permissionStatusList;
  }
}

/// Enum of all available [Permission]
enum Permissions { RecordAudio, Camera, WriteExternalStorage, ReadExternalStorage, AccessCoarseLocation, AccessFineLocation, WhenInUseLocation, AlwaysLocation, ReadContacts, Vibrate, WriteContacts }

/// Permissions status enum (iOs)
enum PermissionStatus { notAgain, deny, allow }

String getPermissionString(Permissions permissions) {
  String res;
  switch (permissions) {
    case Permissions.Camera:
      res = "CAMERA";
      break;
    case Permissions.RecordAudio:
      res = "RECORD_AUDIO";
      break;
    case Permissions.WriteExternalStorage:
      res = "WRITE_EXTERNAL_STORAGE";
      break;
    case Permissions.ReadExternalStorage:
      res = "READ_EXTERNAL_STORAGE";
      break;
    case Permissions.AccessFineLocation:
      res = "ACCESS_FINE_LOCATION";
      break;
    case Permissions.AccessCoarseLocation:
      res = "ACCESS_COARSE_LOCATION";
      break;
    case Permissions.WhenInUseLocation:
      res = "WHEN_IN_USE_LOCATION";
      break;
    case Permissions.AlwaysLocation:
      res = "ALWAYS_LOCATION";
      break;
    case Permissions.ReadContacts:
      res = "READ_CONTACTS";
      break;
    case Permissions.Vibrate:
      res = "VIBRATE";
      break;
    case Permissions.WriteContacts:
      res = "WRITE_CONTACTS";
      break;
  }
  return res;
}
