import 'dart:async';

import 'package:flutter/services.dart';

class Permission {
  static const MethodChannel channel = const MethodChannel('plugins.ly.com/permission');

  static Future<List<Permissions>> getPermissionsStatus(List<PermissionName> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(getPermissionString(p));
    });
    var status = await channel.invokeMethod("getPermissionsStatus", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case 0:
          permissionStatus = PermissionStatus.allow;
          break;
        case 1:
          permissionStatus = PermissionStatus.deny;
          break;
        case 2:
          permissionStatus = PermissionStatus.notDecided;
          break;
        case 3:
          permissionStatus = PermissionStatus.notAgain;
          break;
        default:
          permissionStatus = PermissionStatus.notDecided;
          break;
      }
      permissionStatusList.add(Permissions(permissionNameList[i], permissionStatus));
    }
    return permissionStatusList;
  }

  static Future<PermissionStatus> getSinglePermissionStatus(PermissionName permissionName) async {
    var status = await channel.invokeMethod("getSinglePermissionStatus", {"permissionName": getPermissionString(permissionName)});
    switch (status) {
      case 0:
        return PermissionStatus.allow;
        break;
      case 1:
        return PermissionStatus.deny;
        break;
      case 2:
        return PermissionStatus.notDecided;
        break;
      case 3:
        return PermissionStatus.notAgain;
        break;
      case 4:
        return PermissionStatus.whenInUse;
        break;
      case 5:
        return PermissionStatus.always;
        break;
      default:
        return PermissionStatus.notDecided;
        break;
    }
  }

  static Future<List<Permissions>> requestPermissions(List<PermissionName> permissionNameList) async {
    List<String> list = [];
    permissionNameList.forEach((p) {
      list.add(getPermissionString(p));
    });
    var status = await channel.invokeMethod("requestPermissions", {"permissions": list});
    List<Permissions> permissionStatusList = [];
    for (int i = 0; i < status.length; i++) {
      PermissionStatus permissionStatus;
      switch (status[i]) {
        case 0:
          permissionStatus = PermissionStatus.allow;
          break;
        case 1:
          permissionStatus = PermissionStatus.deny;
          break;
        case 2:
          permissionStatus = PermissionStatus.notDecided;
          break;
        case 3:
          permissionStatus = PermissionStatus.notAgain;
          break;
        default:
          permissionStatus = PermissionStatus.notDecided;
          break;
      }
      permissionStatusList.add(Permissions(permissionNameList[i], permissionStatus));
    }
    return permissionStatusList;
  }

  static Future<PermissionStatus> requestSinglePermission(PermissionName permissionName) async {
    var status = await channel.invokeMethod("requestSinglePermission", {"permissionName": getPermissionString(permissionName)});
    switch (status) {
      case 0:
        return PermissionStatus.allow;
        break;
      case 1:
        return PermissionStatus.deny;
        break;
      case 2:
        return PermissionStatus.notDecided;
        break;
      case 3:
        return PermissionStatus.notAgain;
        break;
      case 4:
        return PermissionStatus.whenInUse;
        break;
      case 5:
        return PermissionStatus.always;
        break;
      default:
        return PermissionStatus.notDecided;
        break;
    }
  }

  static Future<bool> openSettings() async {
    return await channel.invokeMethod("openSettings");
  }
}

enum PermissionName {
  // iOS
  Internet,
  // both
  Calendar,
  // both
  Camera,
  // both
  Contacts,
  // both
  Microphone,
  // both
  Location,
  // iOS
  WhenInUse,
  // Android
  Phone,
  // Android
  Sensors,
  // Android
  SMS,
  // Android
  Storage,
  // Android
  State,
}

enum PermissionStatus { allow, deny, notDecided, notAgain, whenInUse, always }

class Permissions {
  PermissionName permissionName;
  PermissionStatus permissionStatus;

  Permissions(this.permissionName, this.permissionStatus);
}

String getPermissionString(PermissionName permissions) {
  String res;
  switch (permissions) {
    case PermissionName.Internet:
      res = 'Internet';
      break;
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
    case PermissionName.WhenInUse:
      res = 'WhenInUse';
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
    case PermissionName.State:
      res = 'State';
      break;
    default:
      res = '';
      break;
  }
  return res;
}