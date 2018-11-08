import 'package:flutter/material.dart';
import 'package:permission/permission.dart';
import 'package:camera/camera.dart';

List<CameraDescription> cameras;

Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  CameraController controller;
  String get = '';

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

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
              Text('Android:'),
              RaisedButton(onPressed: getPermissionStatus, child: new Text("Get permission status")),
              RaisedButton(onPressed: requestPermissions, child: new Text("Request permissions")),
              RaisedButton(onPressed: requestPermission, child: new Text("Request single permission")),
              RaisedButton(onPressed: Permission.openSettings, child: new Text("Open settings")),
              Text(get),
              SizedBox(
                height: 20,
              ),
              Text('iOS:'),
              AspectRatio(aspectRatio: controller.value.aspectRatio, child: CameraPreview(controller)),
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
