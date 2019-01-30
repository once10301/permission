import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool c0 = true, c1 = false, c2 = false, c3 = false, c4 = false, c5 = false, c6 = false, c7 = false, c8 = false;
  int radioValue = 0;
  PermissionName permissionName = PermissionName.Internet;
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: c0,
                      onChanged: (v) {
                        setState(() {
                          c0 = v;
                        });
                      },
                    ),
                    Text('Calendar'),
                    Checkbox(
                      value: c1,
                      onChanged: (v) {
                        setState(() {
                          c1 = v;
                        });
                      },
                    ),
                    Text('Camera'),
                    Checkbox(
                      value: c2,
                      onChanged: (v) {
                        setState(() {
                          c2 = v;
                        });
                      },
                    ),
                    Text('Contacts'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: c3,
                      onChanged: (v) {
                        setState(() {
                          c3 = v;
                        });
                      },
                    ),
                    Text('Microphone'),
                    Checkbox(
                      value: c4,
                      onChanged: (v) {
                        setState(() {
                          c4 = v;
                        });
                      },
                    ),
                    Text('Location'),
                    Checkbox(
                      value: c5,
                      onChanged: (v) {
                        setState(() {
                          c5 = v;
                        });
                      },
                    ),
                    Text('Phone'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: c6,
                      onChanged: (v) {
                        setState(() {
                          c6 = v;
                        });
                      },
                    ),
                    Text('Sensors'),
                    Checkbox(
                      value: c7,
                      onChanged: (v) {
                        setState(() {
                          c7 = v;
                        });
                      },
                    ),
                    Text('SMS'),
                    Checkbox(
                      value: c8,
                      onChanged: (v) {
                        setState(() {
                          c8 = v;
                        });
                      },
                    ),
                    Text('Storage'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Internet'),
                    Radio(
                      value: 1,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Calendar'),
                    Radio(
                      value: 2,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Radio(
                      value: 3,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Contacts'),
                    Radio(
                      value: 4,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Microphone'),
                    Radio(
                      value: 5,
                      groupValue: radioValue,
                      onChanged: radioValueChange,
                    ),
                    Text('Location'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: RaisedButton(onPressed: getPermissionsStatus, child: new Text("Get permission status")),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: RaisedButton(onPressed: requestPermissions, child: new Text("Request permissions")),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: RaisedButton(onPressed: getSinglePermissionStatus, child: new Text("Get single permission status")),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: RaisedButton(onPressed: requestSinglePermission, child: new Text("Request single permission")),
              ),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Open settings")),
              Text(message),
            ],
          ),
        ),
      ),
    );
  }

  getPermissionsStatus() async {
    List<PermissionName> permissionNames = [];
    if(c0) permissionNames.add(PermissionName.Calendar);
    if(c1) permissionNames.add(PermissionName.Camera);
    if(c2) permissionNames.add(PermissionName.Contacts);
    if(c3) permissionNames.add(PermissionName.Microphone);
    if(c4) permissionNames.add(PermissionName.Location);
    if(c5) permissionNames.add(PermissionName.Phone);
    if(c6) permissionNames.add(PermissionName.Sensors);
    if(c7) permissionNames.add(PermissionName.SMS);
    if(c8) permissionNames.add(PermissionName.Storage);
    message = '';
    List<Permissions> permissions = await Permission.getPermissionsStatus(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      message;
    });
  }

  getSinglePermissionStatus() async {
    var permissionStatus = await Permission.getSinglePermissionStatus(permissionName);
    setState(() {
      message = permissionStatus.toString();
    });
  }

  requestPermissions() async {
    List<PermissionName> permissionNames = [];
    if(c0) permissionNames.add(PermissionName.Calendar);
    if(c1) permissionNames.add(PermissionName.Camera);
    if(c2) permissionNames.add(PermissionName.Contacts);
    if(c3) permissionNames.add(PermissionName.Microphone);
    if(c4) permissionNames.add(PermissionName.Location);
    if(c5) permissionNames.add(PermissionName.Phone);
    if(c6) permissionNames.add(PermissionName.Sensors);
    if(c7) permissionNames.add(PermissionName.SMS);
    if(c8) permissionNames.add(PermissionName.Storage);
    message = '';
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      message;
    });
  }

  requestSinglePermission() async {
    final permissionStatus = await Permission.requestSinglePermission(permissionName);
    setState(() {
      message = permissionStatus.toString();
    });
  }

  void radioValueChange(int value) {
    setState(() {
      radioValue = value;
      switch (radioValue) {
        case 0:
          permissionName = PermissionName.Internet;
          break;
        case 1:
          permissionName = PermissionName.Calendar;
          break;
        case 2:
          permissionName = PermissionName.Camera;
          break;
        case 3:
          permissionName = PermissionName.Contacts;
          break;
        case 4:
          permissionName = PermissionName.Microphone;
          break;
        case 5:
          permissionName = PermissionName.Location;
          break;
      }
    });
  }
}
