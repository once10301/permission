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
        for (NSString *permissionName in permissions) {
            if ([@"Internet" isEqualToString:permissionName]) {
                if (@available(iOS 9.0, *)) {
                    CTCellularData *cellularData = [[CTCellularData alloc] init];
                    cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                        switch (state) {
                            case kCTCellularDataNotRestricted:
                                [list insertObject:@0 atIndex:0];
                                break;
                            case kCTCellularDataRestricted:
                                [list insertObject:@1 atIndex:0];
                                break;
                            case kCTCellularDataRestrictedStateUnknown:
                                [list insertObject:@2 atIndex:0];
                                break;
                            default:
                                [list insertObject:@2 atIndex:0];
                                break;
                        }
                    };
                }
            } else if ([@"Calendar" isEqualToString:permissionName]) {
                EKAuthorizationStatus EKStatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
                switch (EKStatus) {
                    case EKAuthorizationStatusAuthorized:
                        [list addObject:@0];
                        break;
                    case EKAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case EKAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case EKAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            } else if ([@"Camera" isEqualToString:permissionName]){
                PHAuthorizationStatus PHStatus = [PHPhotoLibrary authorizationStatus];
                switch (PHStatus) {
                    case PHAuthorizationStatusAuthorized:
                        [list addObject:@0];
                        break;
                    case PHAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case PHAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case PHAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            } else if ([@"Contacts" isEqualToString:permissionName]){
                if (@available(iOS 9.0, *)) {
                    CNAuthorizationStatus CNStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
                    switch (CNStatus) {
                        case CNAuthorizationStatusAuthorized:
                            [list addObject:@0];
                            break;
                        case CNAuthorizationStatusDenied:
                            [list addObject:@1];
                            break;
                        case CNAuthorizationStatusNotDetermined:
                            [list addObject:@2];
                            break;
                        case CNAuthorizationStatusRestricted:
                            [list addObject:@1];
                            break;
                        default:
                            [list addObject:@2];
                            break;
                    }
                }
            } else if ([@"Microphone" isEqualToString:permissionName]){
                AVAuthorizationStatus AVStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
                switch (AVStatus) {
                    case AVAuthorizationStatusAuthorized:
                        [list addObject:@0];
                        break;
                    case AVAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case AVAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case AVAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            } else if ([@"Location" isEqualToString:permissionName]){
                CLAuthorizationStatus CLStatus =  [CLLocationManager authorizationStatus];
                switch (CLStatus) {
                    case kCLAuthorizationStatusAuthorizedWhenInUse:
                        [list addObject:@4];
                        break;
                    case kCLAuthorizationStatusAuthorizedAlways:
                        [list addObject:@5];
                        break;
                    case kCLAuthorizationStatusDenied:
                        [list addObject:@1];
                        break;
                    case kCLAuthorizationStatusNotDetermined:
                        [list addObject:@2];
                        break;
                    case kCLAuthorizationStatusRestricted:
                        [list addObject:@1];
                        break;
                    default:
                        [list addObject:@2];
                        break;
                }
            }
        }
        while (1) {
            if (list.count == permissions.count) {
                result(list);
                return;
            }
        }
    } else if ([@"requestPermissions" isEqualToString:call.method]) {
        NSDictionary *argsMap = call.arguments;
        NSArray *permissions = argsMap[@"permissions"];
        for (NSString *permissionName in permissions) {
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
        }
    } else if ([@"openSettings" isEqualToString:call.method]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        result(@YES);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end
