package com.ly.permission;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;

import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import java.util.ArrayList;
import java.util.List;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugin.common.PluginRegistry.Registrar;

public class PermissionPlugin implements MethodCallHandler, PluginRegistry.RequestPermissionsResultListener {
    private Registrar registrar;
    private Result result;

    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "plugins.ly.com/permission");
        PermissionPlugin permissionPlugin = new PermissionPlugin(registrar);
        channel.setMethodCallHandler(permissionPlugin);
        registrar.addRequestPermissionsResultListener(permissionPlugin);
    }

    private PermissionPlugin(Registrar registrar) {
        this.registrar = registrar;
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        List<String> permissions = new ArrayList<>();
        switch (call.method) {
            case "getPermissionsStatus":
                permissions = call.argument("permissions");
                result.success(get(permissions));
                break;
            case "requestPermissions":
                permissions = call.argument("permissions");
                this.result = result;
                requests(permissions);
                break;
            case "openSettings":
                openSettings();
                result.success(true);
                break;
            default:
                result.notImplemented();
                break;
        }
    }

    private List<Integer> get(List<String> permissions) {
        List<Integer> intList = new ArrayList<>();
        Activity activity = registrar.activity();
        for (String permission : permissions) {
            permission = getManifestPermission(permission);
            if (ContextCompat.checkSelfPermission(registrar.activity(), permission) == PackageManager.PERMISSION_DENIED) {
                if (!ActivityCompat.shouldShowRequestPermissionRationale(activity, permission)) {
                    intList.add(3);
                } else {
                    intList.add(1);
                }
            } else {
                intList.add(0);
            }
        }
        return intList;
    }

    private void requests(List<String> permissionList) {
        Activity activity = registrar.activity();
        String[] permissions = new String[permissionList.size()];
        for (int i = 0; i < permissionList.size(); i++) {
            permissions[i] = getManifestPermission(permissionList.get(i));
        }
        ActivityCompat.requestPermissions(activity, permissions, 0);
    }

    private void openSettings() {
        Activity activity = registrar.activity();
        Intent intent = new Intent(Settings.ACTION_APPLICATION_DETAILS_SETTINGS, Uri.parse("package:" + activity.getPackageName()));
        intent.addCategory(Intent.CATEGORY_DEFAULT);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        activity.startActivity(intent);
    }

    private String getManifestPermission(String permission) {
        String result;
        switch (permission) {
            case "Calendar":
                result = Manifest.permission.READ_CALENDAR;
                break;
            case "Camera":
                result = Manifest.permission.CAMERA;
                break;
            case "Contacts":
                result = Manifest.permission.READ_CONTACTS;
                break;
            case "Location":
                result = Manifest.permission.ACCESS_FINE_LOCATION;
                break;
            case "Microphone":
                result = Manifest.permission.RECORD_AUDIO;
                break;
            case "Phone":
                result = Manifest.permission.CALL_PHONE;
                break;
            case "Sensors":
                result = Manifest.permission.BODY_SENSORS;
                break;
            case "SMS":
                result = Manifest.permission.READ_SMS;
                break;
            case "Storage":
                result = Manifest.permission.READ_EXTERNAL_STORAGE;
                break;
            default:
                result = "ERROR";
                break;
        }
        return result;
    }

    @Override
    public boolean onRequestPermissionsResult(int requestCode, String[] strings, int[] ints) {
        if (requestCode == 0 && ints.length > 0) {
            List<Integer> intList = new ArrayList<>();
            for (int i = 0; i < ints.length; i++) {
                if (ints[i] == PackageManager.PERMISSION_DENIED) {
                    if (!ActivityCompat.shouldShowRequestPermissionRationale(registrar.activity(), strings[i])) {
                        intList.add(3);
                    } else {
                        intList.add(1);
                    }
                } else {
                    intList.add(0);
                }
            }
            result.success(intList);
        }
        return true;
    }
}
