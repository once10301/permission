#import "PermissionPlugin.h"
#import <CoreLocation/CLLocationManager.h>
#import <EventKit/EventKit.h>
#import <Photos/PHPhotoLibrary.h>
#import <Contacts/Contacts.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreLocation/CoreLocation.h>

@import AVFoundation;
@import CoreTelephony;
CLLocationManager *locationManager;
@implementation PermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"plugins.ly.com/permission"
                                     binaryMessenger:[registrar messenger]];
    PermissionPlugin* instance = [[PermissionPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPermissionsStatus" isEqualToString:call.method]) {
        NSDictionary *argsMap = call.arguments;
        NSArray *permissions = argsMap[@"permissions"];
        NSMutableArray *list = @[].mutableCopy;
        for(NSString *a in permissions){
            [list addObject:@-1];
        }
        for (int i = 0; i < permissions.count; i++) {
            NSString *permissionName = permissions[i];
            if ([@"Internet" isEqualToString:permissionName]) {
                if (@available(iOS 9.0, *)) {
                    CTCellularData *cellularData = [[CTCellularData alloc] init];
                    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                        switch (state) {
                            case kCTCellularDataNotRestricted:
                                list[i] = @0;
                                break;
                            case kCTCellularDataRestricted:
                                list[i] = @1;
                                break;
                            case kCTCellularDataRestrictedStateUnknown:
                                list[i] = @2;
                                break;
                            default:
                                list[i] = @2;
                                break;
                        }
                    };
                }
            } else if ([@"Calendar" isEqualToString:permissionName]) {
                EKAuthorizationStatus EKStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                switch (EKStatus) {
                    case EKAuthorizationStatusAuthorized:
                        list[i] = @0;
                        break;
                    case EKAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case EKAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case EKAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Camera" isEqualToString:permissionName]){
                AVAuthorizationStatus AVStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
                switch (AVStatus) {
                    case AVAuthorizationStatusAuthorized:
                        list[i] = @0;
                        break;
                    case AVAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case AVAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case AVAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Contacts" isEqualToString:permissionName]){
                if (@available(iOS 9.0, *)) {
                    CNAuthorizationStatus CNStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                    switch (CNStatus) {
                        case CNAuthorizationStatusAuthorized:
                            list[i] = @0;
                            break;
                        case CNAuthorizationStatusDenied:
                            list[i] = @1;
                            break;
                        case CNAuthorizationStatusNotDetermined:
                            list[i] = @2;
                            break;
                        case CNAuthorizationStatusRestricted:
                            list[i] = @1;
                            break;
                        default:
                            list[i] = @2;
                            break;
                    }
                }
            } else if ([@"Microphone" isEqualToString:permissionName]){
                AVAuthorizationStatus AVStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                switch (AVStatus) {
                    case AVAuthorizationStatusAuthorized:
                        list[i] = @0;
                        break;
                    case AVAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case AVAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case AVAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Location" isEqualToString:permissionName]){
                CLAuthorizationStatus CLStatus =  [CLLocationManager authorizationStatus];
                switch (CLStatus) {
                    case kCLAuthorizationStatusAuthorizedWhenInUse:
                        list[i] = @0;
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways:
                        list[i] = @0;
                        break;
                    case kCLAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case kCLAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case kCLAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Storage" isEqualToString:permissionName]){
                PHAuthorizationStatus PHStatus = [PHPhotoLibrary authorizationStatus];
                switch (PHStatus) {
                    case PHAuthorizationStatusAuthorized:
                        list[i] = @0;
                        break;
                    case PHAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case PHAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case PHAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            }
        }
        while (1) {
            BOOL flag = true;
            for (int i = 0; i < list.count; i++) {
                NSNumber *a = list[i];
                if(a.integerValue == -1) {
                    flag = false;
                }
            }
            if(flag){
                result(list);
                return;
            }
        }
    } else if ([@"requestPermissions" isEqualToString:call.method]) {
        NSDictionary *argsMap = call.arguments;
        NSArray *permissions = argsMap[@"permissions"];
        NSMutableArray *list = @[].mutableCopy;
        for(NSString *a in permissions){
            [list addObject:@-1];
        }
        for (int i = 0; i < permissions.count; i++) {
            NSString *permissionName = permissions[i];
            if ([@"Internet" isEqualToString:permissionName]) {
                NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
                NSURLRequest *request = [NSURLRequest requestWithURL:url];
                NSURLSession *session = [NSURLSession sharedSession];
                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                }];
                [dataTask resume];
                if (@available(iOS 9.0, *)) {
                    CTCellularData *cellularData = [[CTCellularData alloc] init];
                    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                        switch (state) {
                            case kCTCellularDataNotRestricted:
                                list[i] = @0;
                                break;
                            case kCTCellularDataRestricted:
                                list[i] = @1;
                                break;
                            case kCTCellularDataRestrictedStateUnknown:
                                list[i] = @2;
                                break;
                            default:
                                list[i] = @2;
                                break;
                        }
                    };
                }
            } else if ([@"Calendar" isEqualToString:permissionName]){
                EKEventStore *eventStore = [[EKEventStore alloc] init];
                [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                    if (error) {
                        list[i] = @2;
                        return;
                    }
                    if (granted) {
                        list[i] = @0;
                    } else {
                        list[i] = @1;
                    }
                }];
            } else if ([@"Camera" isEqualToString:permissionName]){
                AVAuthorizationStatus AVStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                switch (AVStatus) {
                    case AVAuthorizationStatusAuthorized:
                        list[i] = @0;
                        break;
                    case AVAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case AVAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case AVAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Contacts" isEqualToString:permissionName]){
                if (@available(iOS 9.0, *)) {
                    CNContactStore *contactStore = [[CNContactStore alloc] init];
                    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                        if (error) {
                            list[i] = @2;
                            return;
                        }
                        if (granted) {
                            list[i] = @0;
                        } else {
                            list[i] = @1;
                        }
                    }];
                }
            } else if ([@"Microphone" isEqualToString:permissionName]){
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                    if (granted) {
                        list[i] = @0;
                    } else {
                        list[i] = @1;
                    }
                }];
            } else if ([@"Location" isEqualToString:permissionName]){
                locationManager = [[CLLocationManager alloc] init];
                [locationManager requestAlwaysAuthorization];
                CLAuthorizationStatus CLStatus =  [CLLocationManager authorizationStatus];
                switch (CLStatus) {
                    case kCLAuthorizationStatusAuthorizedWhenInUse:
                        list[i] = @0;
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways:
                        list[i] = @0;
                        break;
                    case kCLAuthorizationStatusDenied:
                        list[i] = @1;
                        break;
                    case kCLAuthorizationStatusNotDetermined:
                        list[i] = @2;
                        break;
                    case kCLAuthorizationStatusRestricted:
                        list[i] = @1;
                        break;
                    default:
                        list[i] = @2;
                        break;
                }
            } else if ([@"Storage" isEqualToString:permissionName]){
                [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus PHStatus) {
                    switch (PHStatus) {
                        case PHAuthorizationStatusAuthorized:
                            list[i] = @0;
                            break;
                        case PHAuthorizationStatusDenied:
                            list[i] = @1;
                            break;
                        case PHAuthorizationStatusNotDetermined:
                            list[i] = @2;
                            break;
                        case PHAuthorizationStatusRestricted:
                            list[i] = @1;
                            break;
                        default:
                            list[i] = @2;
                            break;
                    }
                }];
            }
        }
        while (1) {
            BOOL flag = true;
            for (int i = 0; i < list.count; i++) {
                NSNumber *a = list[i];
                if(a.integerValue == -1) {
                    flag = false;
                }
            }
            if(flag){
                result(list);
                return;
            }
        }
    } else if ([@"openSettings" isEqualToString:call.method]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
