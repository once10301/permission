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
  bool a0 = false, a1 = false, a2 = false, a3 = false, a4 = false, a5 = false, a6 = false, a7 = false, a8 = false, a9 = false;
  bool i0 = false, i1 = false, i2 = false, i3 = false, i4 = false, i5 = false, i6 = false;
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
                      value: a0,
                      onChanged: (v) {
                        setState(() {
                          a0 = v;
                        });
                      },
                    ),
                    Text('Calendar'),
                    Checkbox(
                      value: a1,
                      onChanged: (v) {
                        setState(() {
                          a1 = v;
                        });
                      },
                    ),
                    Text('Camera'),
                    Checkbox(
                      value: a2,
                      onChanged: (v) {
                        setState(() {
                          a2 = v;
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
                      value: a3,
                      onChanged: (v) {
                        setState(() {
                          a3 = v;
                        });
                      },
                    ),
                    Text('Microphone'),
                    Checkbox(
                      value: a4,
                      onChanged: (v) {
                        setState(() {
                          a4 = v;
                        });
                      },
                    ),
                    Text('Location'),
                    Checkbox(
                      value: a5,
                      onChanged: (v) {
                        setState(() {
                          a5 = v;
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
                      value: a6,
                      onChanged: (v) {
                        setState(() {
                          a6 = v;
                        });
                      },
                    ),
                    Text('Sensors'),
                    Checkbox(
                      value: a7,
                      onChanged: (v) {
                        setState(() {
                          a7 = v;
                        });
                      },
                    ),
                    Text('SMS'),
                    Checkbox(
                      value: a8,
                      onChanged: (v) {
                        setState(() {
                          a8 = v;
                        });
                      },
                    ),
                    Text('Storage'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isAndroid,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: a9,
                      onChanged: (v) {
                        setState(() {
                          a9 = v;
                        });
                      },
                    ),
                    Text('State'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: i0,
                      onChanged: (v) {
                        setState(() {
                          i0 = v;
                        });
                      },
                    ),
                    Text('Internet'),
                    Checkbox(
                      value: i1,
                      onChanged: (v) {
                        setState(() {
                          i1 = v;
                        });
                      },
                    ),
                    Text('Calendar'),
                    Checkbox(
                      value: i2,
                      onChanged: (v) {
                        setState(() {
                          i2 = v;
                        });
                      },
                    ),
                    Text('Camera'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: i3,
                      onChanged: (v) {
                        setState(() {
                          i3 = v;
                        });
                      },
                    ),
                    Text('Contacts'),
                    Checkbox(
                      value: i4,
                      onChanged: (v) {
                        setState(() {
                          i4 = v;
                        });
                      },
                    ),
                    Text('Microphone'),
                    Checkbox(
                      value: i5,
                      onChanged: (v) {
                        setState(() {
                          i5 = v;
                        });
                      },
                    ),
                    Text('Location'),
                  ],
                ),
              ),
              Offstage(
                offstage: !Platform.isIOS,
                child: Row(
                  children: <Widget>[
                    Checkbox(
                      value: i6,
                      onChanged: (v) {
                        setState(() {
                          i6 = v;
                        });
                      },
                    ),
                    Text('Storage'),
                  ],
                ),
              ),
              RaisedButton(onPressed: getPermissionsStatus, child: new Text("Get permission status")),
              RaisedButton(onPressed: requestPermissions, child: new Text("Request permissions")),
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
    if (a0) permissionNames.add(PermissionName.Calendar);
    if (a1) permissionNames.add(PermissionName.Camera);
    if (a2) permissionNames.add(PermissionName.Contacts);
    if (a3) permissionNames.add(PermissionName.Microphone);
    if (a4) permissionNames.add(PermissionName.Location);
    if (a5) permissionNames.add(PermissionName.Phone);
    if (a6) permissionNames.add(PermissionName.Sensors);
    if (a7) permissionNames.add(PermissionName.SMS);
    if (a8) permissionNames.add(PermissionName.Storage);

    if (i0) permissionNames.add(PermissionName.Internet);
    if (i1) permissionNames.add(PermissionName.Calendar);
    if (i2) permissionNames.add(PermissionName.Camera);
    if (i3) permissionNames.add(PermissionName.Contacts);
    if (i4) permissionNames.add(PermissionName.Microphone);
    if (i5) permissionNames.add(PermissionName.Location);
    if (i6) permissionNames.add(PermissionName.Storage);
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
    if (a0) permissionNames.add(PermissionName.Calendar);
    if (a1) permissionNames.add(PermissionName.Camera);
    if (a2) permissionNames.add(PermissionName.Contacts);
    if (a3) permissionNames.add(PermissionName.Microphone);
    if (a4) permissionNames.add(PermissionName.Location);
    if (a5) permissionNames.add(PermissionName.Phone);
    if (a6) permissionNames.add(PermissionName.Sensors);
    if (a7) permissionNames.add(PermissionName.SMS);
    if (a8) permissionNames.add(PermissionName.Storage);
    if (a9) permissionNames.add(PermissionName.State);

    if (i0) permissionNames.add(PermissionName.Internet);
    if (i1) permissionNames.add(PermissionName.Calendar);
    if (i2) permissionNames.add(PermissionName.Camera);
    if (i3) permissionNames.add(PermissionName.Contacts);
    if (i4) permissionNames.add(PermissionName.Microphone);
    if (i5) permissionNames.add(PermissionName.Location);
    if (i6) permissionNames.add(PermissionName.Storage);
    message = '';
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((permission) {
      message += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {});
  }
}
