# permission

A new flutter plugin for getting and requesting permission on Android.

## Getting Started

```
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
  // Android
  Phone,
  // Android
  Sensors,
  // Android
  SMS,
  // Android
  Storage
}
```

####Android:

Only dangerous permissions require user agreement. 

Permissions are organized into groups related to a device's capabilities or features. Under this system, permission requests are handled at the group level and a single permission group corresponds to several permission declarations in the app manifest.

Dangerous permissions and permission groups.

<table>
    <tr>
        <td>Permission Group</td>
        <td>Permissions</td>
    </tr>
    <tr>
        <td rowspan="2">CALENDAR</td> 
        <td >READ_CALENDAR</td>
    </tr>
    <tr>
        <td >WRITE_CALENDAR</td>
    </tr>
    <tr>
        <td>CAMERA</td>
        <td>CAMERA</td>
    </tr>
    <tr>
        <td rowspan="3">CONTACTS</td>
        <td >READ_CONTACTS</td>
    </tr>
    <tr>
        <td >WRITE_CONTACTS</td>
    </tr>
    <tr>
        <td >GET_ACCOUNTS</td>
    </tr>
    <tr>
        <td rowspan="2">LOCATION</td>
        <td >ACCESS_FINE_LOCATION</td>
    </tr>
    <tr>
        <td >ACCESS_COARSE_LOCATION</td>
    </tr>
    <tr>
        <td>MICROPHONE</td>
        <td>RECORD_AUDIO</td>
    </tr>
    <tr>
        <td rowspan="7">PHONE</td>
        <td >READ_PHONE_STATE</td>
    </tr>
    <tr>
        <td >CALL_PHONE</td>
    </tr>
    <tr>
        <td >READ_CALL_LOG</td>
    </tr>
    <tr>
        <td >WRITE_CALL_LOG</td>
    </tr>
    <tr>
        <td >ADD_VOICEMAIL</td>
    </tr>
    <tr>
        <td >USE_SIP</td>
    </tr>
    <tr>
        <td >PROCESS_OUTGOING_CALLS</td>
    </tr>
    <tr>
        <td>SENSORS</td>
        <td>BODY_SENSORS</td>
    </tr>
    <tr>
        <td rowspan="5">SMS</td>
        <td >SEND_SMS</td>
    </tr>
    <tr>
        <td >RECEIVE_SMS</td>
    </tr>
    <tr>
        <td >READ_SMS</td>
    </tr>
    <tr>
        <td >RECEIVE_WAP_PUSH</td>
    </tr>
    <tr>
        <td >RECEIVE_MMS</td>
    </tr>
    <tr>
        <td rowspan="2">STORAGE</td>
        <td >READ_EXTERNAL_STORAGE</td>
    </tr>
    <tr>
        <td >WRITE_EXTERNAL_STORAGE</td>
    </tr>
</table>	

Make sure you add the needed permissions to your Android Manifest Permission.

```xml
<uses-permission android:name="android.permission.READ_CALENDAR" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.READ_CONTACTS" />
<uses-permission android:name="android.permission.WRITE_CONTACTS" />
<uses-permission android:name="android.permission.GET_ACCOUNTS" />
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.READ_PHONE_STATE" />
<uses-permission android:name="android.permission.CALL_PHONE" />
<uses-permission android:name="android.permission.READ_CALL_LOG" />
<uses-permission android:name="android.permission.WRITE_CALL_LOG" />
<uses-permission android:name="android.permission.WRITE_CALENDAR" />
<uses-permission android:name="android.permission.ADD_VOICEMAIL" />
<uses-permission android:name="android.permission.USE_SIP" />
<uses-permission android:name="android.permission.PROCESS_OUTGOING_CALLS" />
<uses-permission android:name="android.permission.BODY_SENSORS" />
<uses-permission android:name="android.permission.SEND_SMS" />
<uses-permission android:name="android.permission.RECEIVE_SMS" />
<uses-permission android:name="android.permission.READ_SMS" />
<uses-permission android:name="android.permission.RECEIVE_WAP_PUSH" />
<uses-permission android:name="android.permission.RECEIVE_MMS" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
```

#### iOS

 Add the needed permissions to your info.plist

```objective-c
 <key>NSCalendarsUsageDescription</key>
 <string>Your prompt</string>
 <key>NSCameraUsageDescription</key>
 <string>Your prompt</string>
 <key>NSContactsUsageDescription</key>
 <string>Your prompt</string>
 <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
 <string>Your prompt</string>
 <key>NSLocationWhenInUseUsageDescription</key>
 <string>Your prompt</string>
 <key>NSMicrophoneUsageDescription</key>
 <string>Your prompt</string>
 <key>NSPhotoLibraryUsageDescription</key>
 <string>Your prompt</string>
 <key>NSRemindersUsageDescription</key>
 <string>Your prompt</string>
```

#### Methods

```dart
import 'package:permission/permission.dart';

# Android
List<Permissions> permissions = await Permission.getPermissionStatus([PermissionName.Calendar, PermissionName.Camera]);

List<PermissionName> permissionNames = await Permission.requestPermissions([PermissionName.Calendar, PermissionName.Camera]);

# iOS
PermissionStatus permissionStatus = await Permission.getSinglePermissionStatus(PermissionName.Calendar);

PermissionStatus permissionStatus = await Permission.requestSinglePermission(PermissionName.Calendar);

# Both
Permission.openSettings;
```

#### 