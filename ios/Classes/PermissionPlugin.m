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
    if ([@"getSinglePermissionStatus" isEqualToString:call.method]) {
        NSDictionary* argsMap = call.arguments;
        NSString *permissionName = argsMap[@"permissionName"];
        if ([@"Internet" isEqualToString:permissionName]) {
            if (@available(iOS 9.0, *)) {
                CTCellularData *cellularData = [[CTCellularData alloc] init];
                cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                    switch (state) {
                        case kCTCellularDataNotRestricted:
                            result(@0);
                            break;
                        case kCTCellularDataRestricted:
                            result(@1);
                            break;
                        case kCTCellularDataRestrictedStateUnknown:
                            result(@2);
                            break;
                        default:
                            result(@2);
                            break;
                    }
                };
            }
        } else if ([@"Calendar" isEqualToString:permissionName]) {
            EKAuthorizationStatus EKStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
            switch (EKStatus) {
                case EKAuthorizationStatusAuthorized:
                    result(@0);
                    break;
                case EKAuthorizationStatusDenied:
                    result(@1);
                    break;
                case EKAuthorizationStatusNotDetermined:
                    result(@2);
                    break;
                case EKAuthorizationStatusRestricted:
                    result(@1);
                    break;
                default:
                    result(@2);
                    break;
            }
        } else if ([@"Camera" isEqualToString:permissionName]){
            PHAuthorizationStatus PHStatus = [PHPhotoLibrary authorizationStatus];
            switch (PHStatus) {
                case PHAuthorizationStatusAuthorized:
                    result(@0);
                    break;
                case PHAuthorizationStatusDenied:
                    result(@1);
                    break;
                case PHAuthorizationStatusNotDetermined:
                    result(@2);
                    break;
                case PHAuthorizationStatusRestricted:
                    result(@1);
                    break;
                default:
                    result(@2);
                    break;
            }
        } else if ([@"Contacts" isEqualToString:permissionName]){
            if (@available(iOS 9.0, *)) {
                CNAuthorizationStatus CNStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                switch (CNStatus) {
                    case CNAuthorizationStatusAuthorized:
                        result(@0);
                        break;
                    case CNAuthorizationStatusDenied:
                        result(@1);
                        break;
                    case CNAuthorizationStatusNotDetermined:
                        result(@2);
                        break;
                    case CNAuthorizationStatusRestricted:
                        result(@1);
                        break;
                    default:
                        result(@2);
                        break;
                }
            }
        } else if ([@"Microphone" isEqualToString:permissionName]){
            AVAuthorizationStatus AVStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
            switch (AVStatus) {
                case AVAuthorizationStatusAuthorized:
                    result(@0);
                    break;
                case AVAuthorizationStatusDenied:
                    result(@1);
                    break;
                case AVAuthorizationStatusNotDetermined:
                    result(@2);
                    break;
                case AVAuthorizationStatusRestricted:
                    result(@1);
                    break;
                default:
                    result(@2);
                    break;
            }
        } else if ([@"Location" isEqualToString:permissionName]){
            CLAuthorizationStatus CLStatus =  [CLLocationManager authorizationStatus];
            switch (CLStatus) {
                case kCLAuthorizationStatusAuthorizedWhenInUse:
                    result(@4);
                    break;
                case kCLAuthorizationStatusAuthorizedAlways:
                    result(@5);
                    break;
                case kCLAuthorizationStatusDenied:
                    result(@1);
                    break;
                case kCLAuthorizationStatusNotDetermined:
                    result(@2);
                    break;
                case kCLAuthorizationStatusRestricted:
                    result(@1);
                    break;
                default:
                    result(@2);
                    break;
            }
        }
    } else if ([@"requestSinglePermission" isEqualToString:call.method]) {
        NSDictionary* argsMap = call.arguments;
        NSString *permissionName = argsMap[@"permissionName"];
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
                            result(@0);
                            break;
                        case kCTCellularDataRestricted:
                            result(@1);
                            break;
                        case kCTCellularDataRestrictedStateUnknown:
                            result(@2);
                            break;
                        default:
                            result(@2);
                            break;
                    }
                };
            }
        } else if ([@"Calendar" isEqualToString:permissionName]){
            EKEventStore *eventStore = [[EKEventStore alloc] init];
            [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
                if (error) {
                    result(@2);
                    return;
                }
                if (granted) {
                    result(@0);
                } else {
                    result(@1);
                }
            }];
        } else if ([@"Camera" isEqualToString:permissionName]){
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus PHStatus) {
                switch (PHStatus) {
                    case PHAuthorizationStatusAuthorized:
                        result(@0);
                        break;
                    case PHAuthorizationStatusDenied:
                        result(@1);
                        break;
                    case PHAuthorizationStatusNotDetermined:
                        result(@2);
                        break;
                    case PHAuthorizationStatusRestricted:
                        result(@1);
                        break;
                    default:
                        result(@2);
                        break;
                }
            }];
        } else if ([@"Contacts" isEqualToString:permissionName]){
            if (@available(iOS 9.0, *)) {
                CNContactStore *contactStore = [[CNContactStore alloc] init];
                [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
                    if (error) {
                        result(@2);
                        return;
                    }
                    if (granted) {
                        result(@0);
                    } else {
                        result(@1);
                    }
                }];
            }
        } else if ([@"Microphone" isEqualToString:permissionName]){
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    result(@0);
                } else {
                    result(@1);
                }
            }];
        } else if ([@"Location" isEqualToString:permissionName]){
            locationManager = [[CLLocationManager alloc] init];
            [locationManager requestAlwaysAuthorization];
        }
    } else if ([@"openSettings" isEqualToString:call.method]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
