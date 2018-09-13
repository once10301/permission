import 'dart:async';

import 'package:flutter/services.dart';

class Permission {
  static const MethodChannel _channel = const MethodChannel('plugins.ly.com/permission');

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
          permissionStatus = PermissionStatus.noAgain;
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

  static Future<List<Permissions>> requestPermissions(List<PermissionName> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(getPermissionString(p));
    });
    var status = await _channel.invokeMethod("requestPermissions", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case -1:
          permissionStatus = PermissionStatus.noAgain;
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

  static Future<PermissionStatus> requestSinglePermission(PermissionName permissionName) async {
    var status = await _channel.invokeMethod("requestPermissions", {
      "permissions": [getPermissionString(permissionName)]
    });
    switch (status[0]) {
      case -1:
        return PermissionStatus.noAgain;
      case 0:
        return PermissionStatus.deny;
      case 1:
        return PermissionStatus.allow;
      default:
        return PermissionStatus.deny;
    }
  }

  static Future<bool> openSettings() async {
    return await _channel.invokeMethod("openSettings");
  }
}

/// Enum of all available [Permission]
enum PermissionName { Calendar, Camera, Contacts, Microphone, Location, Phone, Sensors, SMS, Storage }

/// Permissions status enum (iOs)
enum PermissionStatus { noAgain, deny, allow }

class Permissions {
  PermissionName permissionName;
  PermissionStatus permissionStatus;

  Permissions(this.permissionName, this.permissionStatus);
}

String getPermissionString(PermissionName permissions) {
  String res;
  switch (permissions) {
    case PermissionName.Calendar:
      res = 'Calendar';
      break;
    case PermissionName.Camera:
      res = 'Camera';
      break;
    case PermissionName.Contacts:
      res = 'Contacts';
      break;
    case PermissionName.Microphone:
      res = 'Microphone';
      break;
    case PermissionName.Location:
      res = 'Location';
      break;
    case PermissionName.Phone:
      res = 'Phone';
      break;
    case PermissionName.Sensors:
      res = 'Sensors';
      break;
    case PermissionName.SMS:
      res = 'SMS';
      break;
    case PermissionName.Storage:
      res = 'Storage';
      break;
    default:
      res = '';
      break;
  }
  return res;
}