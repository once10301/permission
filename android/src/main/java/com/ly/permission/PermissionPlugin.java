package com.ly.permission;

import android.Manifest;
import android.app.Activity;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.net.Uri;
import android.provider.Settings;

import android.support.v4.app.ActivityCompat;
import android.support.v4.content.ContextCompat;

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
        List<String> permissions;
        switch (call.method) {
            case "getPlatformVersion":
                result.success("Android " + android.os.Build.VERSION.RELEASE);
                break;
            case "getPermissionStatus":
                permissions = call.argument("permissions");
                result.success(getPermissions(permissions));
                break;
            case "requestPermission":
                permissions = call.argument("permission");
                this.result = result;
                requestPermissions(permissions);
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

    private List<Integer> getPermissions(List<String> permissions) {
        List<Integer> intList = new ArrayList<>();
        Activity activity = registrar.activity();
        for (String permission : permissions) {
            permission = getManifestPermission(permission);
            if (ContextCompat.checkSelfPermission(registrar.activity(), permission) == PackageManager.PERMISSION_DENIED) {
                if (!ActivityCompat.shouldShowRequestPermissionRationale(activity, permission)) {
                    intList.add(-1);
                } else {
                    intList.add(0);
                }
            } else {
                intList.add(1);
            }
        }
        return intList;
    }

    private void requestPermissions(List<String> permissionList) {
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
            case "RECORD_AUDIO":
                result = Manifest.permission.RECORD_AUDIO;
                break;
            case "CAMERA":
                result = Manifest.permission.CAMERA;
                break;
            case "WRITE_EXTERNAL_STORAGE":
                result = Manifest.permission.WRITE_EXTERNAL_STORAGE;
                break;
            case "READ_EXTERNAL_STORAGE":
                result = Manifest.permission.READ_EXTERNAL_STORAGE;
                break;
            case "ACCESS_FINE_LOCATION":
                result = Manifest.permission.ACCESS_FINE_LOCATION;
                break;
            case "ACCESS_COARSE_LOCATION":
                result = Manifest.permission.ACCESS_COARSE_LOCATION;
                break;
            case "WHEN_IN_USE_LOCATION":
                result = Manifest.permission.ACCESS_FINE_LOCATION;
                break;
            case "ALWAYS_LOCATION":
                result = Manifest.permission.ACCESS_FINE_LOCATION;
                break;
            case "READ_CONTACTS":
                result = Manifest.permission.READ_CONTACTS;
                break;
            case "VIBRATE":
                result = Manifest.permission.VIBRATE;
                break;
            case "WRITE_CONTACTS":
                result = Manifest.permission.WRITE_CONTACTS;
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
                        intList.add(-1);
                    } else {
                        intList.add(0);
                    }
                } else {
                    intList.add(1);
                }
            }
            result.success(intList);
        }
        return false;
    }
}
