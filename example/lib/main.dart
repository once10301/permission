import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:permission/permission.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Plugin example app'),
        ),
        body: Center(
          child: new Column(
            children: <Widget>[
              RaisedButton(onPressed: getPermissionStatus, child: new Text("Get permission status")),
              RaisedButton(onPressed: requestPermission, child: new Text("Request permission")),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Open settings")),
            ],
          ),
        ),
      ),
    );
  }

  getPermissionStatus() async {
    var res = await Permission.getPermissionStatus([PermissionName.Camera, PermissionName.AccessFineLocation]);
    print(res);
  }

  requestPermission() async {
    final res = await Permission.requestPermission([PermissionName.Camera, PermissionName.AccessFineLocation]);
    res.forEach((permission){
      print(permission.permissionName);
      print(permission.permissionStatus);
    });
  }
}
