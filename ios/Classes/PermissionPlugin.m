#import "PermissionPlugin.h"
#import <EventKit/EventKit.h>
#import <AVFoundation/AVFoundation.h>

@import AVFoundation;
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
        result(FlutterMethodNotImplemented);
    }
}
@end
