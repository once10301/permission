#import "PermissionPlugin.h"
#import <CoreLocation/CLLocationManager.h>

@import AVFoundation;

@implementation PermissionPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"permission"
            binaryMessenger:[registrar messenger]];
  PermissionPlugin* instance = [[PermissionPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}
@end
