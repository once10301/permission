import 'package:flutter/material.dart';
import 'package:permission/permission.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String get = '';

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
              RaisedButton(onPressed: requestPermissions, child: new Text("Request permissions")),
              RaisedButton(onPressed: requestPermission, child: new Text("Request single permission")),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Open settings")),
              Text(get),
            ],
          ),
        ),
      ),
    );
  }

  getPermissionStatus() async {
    get = '';
    List<Permissions> permissions = await Permission.getPermissionStatus([PermissionName.Calendar, PermissionName.Camera, PermissionName.Contacts, PermissionName.Location, PermissionName.Microphone, PermissionName.Phone, PermissionName.Sensors, PermissionName.SMS, PermissionName.Storage]);
    permissions.forEach((permission) {
      get += '${permission.permissionName}: ${permission.permissionStatus}\n';
    });
    setState(() {
      get;
    });
  }

  requestPermissions() async {
    final res = await Permission.requestPermissions([PermissionName.Calendar, PermissionName.Camera, PermissionName.Contacts, PermissionName.Location, PermissionName.Microphone, PermissionName.Phone, PermissionName.Sensors, PermissionName.SMS, PermissionName.Storage]);
    res.forEach((permission) {});
  }

  requestPermission() async {
    final res = await Permission.requestSinglePermission(PermissionName.Calendar);
    print(res);
  }
}
