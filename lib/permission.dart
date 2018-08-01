import 'dart:async';

import 'package:flutter/services.dart';

class Permission {
  static const MethodChannel _channel = const MethodChannel('plugins.ly.com/permission');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<List<Permissions>> getPermissionStatus(List<PermissionName> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(getPermissionString(p));
    });
    var status = await _channel.invokeMethod("getPermissionStatus", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case -1:
          permissionStatus = PermissionStatus.notAgain;
          break;
        case 0:
          permissionStatus = PermissionStatus.deny;
          break;
        case 1:
          permissionStatus = PermissionStatus.allow;
          break;
        default:
          permissionStatus = PermissionStatus.deny;
          break;
      }
      permissionStatusList.add(Permissions(permissionNameList[i], permissionStatus));
    }
    return permissionStatusList;
  }

  static Future<List<Permissions>> requestPermission(List<PermissionName> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(getPermissionString(p));
    });
    var status = await _channel.invokeMethod("requestPermission", {"permissions": list});
    print(status);
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case -1:
          permissionStatus = PermissionStatus.notAgain;
          break;
        case 0:
          permissionStatus = PermissionStatus.deny;
          break;
        case 1:
          permissionStatus = PermissionStatus.allow;
          break;
        default:
          permissionStatus = PermissionStatus.deny;
          break;
      }
      permissionStatusList.add(Permissions(permissionNameList[i], permissionStatus));
    }
    return permissionStatusList;
  }

  static Future<bool> openSettings() async {
    return await _channel.invokeMethod("openSettings");
  }
}

/// Enum of all available [Permission]
enum PermissionName { RecordAudio, Camera, WriteExternalStorage, ReadExternalStorage, AccessCoarseLocation, AccessFineLocation, WhenInUseLocation, AlwaysLocation, ReadContacts, Vibrate, WriteContacts }

/// Permissions status enum (iOs)
enum PermissionStatus { notAgain, deny, allow }

class Permissions {
  PermissionName permissionName;
  PermissionStatus permissionStatus;

  Permissions(this.permissionName, this.permissionStatus);
}

String getPermissionString(PermissionName permissions) {
  String res;
  switch (permissions) {
    case PermissionName.Camera:
      res = "CAMERA";
      break;
    case PermissionName.RecordAudio:
      res = "RECORD_AUDIO";
      break;
    case PermissionName.WriteExternalStorage:
      res = "WRITE_EXTERNAL_STORAGE";
      break;
    case PermissionName.ReadExternalStorage:
      res = "READ_EXTERNAL_STORAGE";
      break;
    case PermissionName.AccessFineLocation:
      res = "ACCESS_FINE_LOCATION";
      break;
    case PermissionName.AccessCoarseLocation:
      res = "ACCESS_COARSE_LOCATION";
      break;
    case PermissionName.WhenInUseLocation:
      res = "WHEN_IN_USE_LOCATION";
      break;
    case PermissionName.AlwaysLocation:
      res = "ALWAYS_LOCATION";
      break;
    case PermissionName.ReadContacts:
      res = "READ_CONTACTS";
      break;
    case PermissionName.Vibrate:
      res = "VIBRATE";
      break;
    case PermissionName.WriteContacts:
      res = "WRITE_CONTACTS";
      break;
  }
  return res;
}
