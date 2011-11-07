//
//  MixiSDKSampleAppDelegate.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "MixiSDKSampleAppDelegate.h"

#import "RequestViewController.h"
#import "MixiSDK.h"
#import "Config.h"

@implementation MixiSDKSampleAppDelegate


@synthesize window=_window;

@synthesize mainViewController=_mainViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Add the main view controller's view to the window and display.
#ifdef PleaseInputTheseConstansAndDeleteThisLine
    MixiUtilShowErrorMessage(@"Config.hを設定してください。");
    return NO;
#endif
    self.window.rootViewController = self.mainViewController;
    [self.window makeKeyAndVisible];
    
    Mixi *mixi = [Mixi sharedMixi];
    [mixi setupWithType:kMixiApiTypeSelectorGraphApi clientId:kMixiGraphClientId secret:kMixiGraphClientSecret appId:kAppId];
    [mixi restore];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    NSError *error = nil;
    Mixi *mixi = [Mixi sharedMixi];
    NSString *apiType = [mixi application:application openURL:url sourceApplication:sourceApplication annotation:annotation error:&error];
    NSString *message = nil;
    if (error) {
        message = [NSString stringWithFormat:@"エラーが発生しました: %@", error];
    }
    else if ([apiType isEqualToString:kMixiAppApiTypeToken]) {
        message = @"認可処理に成功しました";
    }
    else if ([apiType isEqualToString:kMixiAppApiTypeRevoke]) {
        message = @"認可解除処理に成功しました";
        [mixi logout];
    }
    if (message) {
        [[[[UIAlertView alloc]
           initWithTitle:@"API実行結果"
           message:message
           delegate:nil
           cancelButtonTitle:nil
           otherButtonTitles:@"OK", nil
           ] autorelease] show];        
    }
    return YES;
}

- (void)dealloc
{
    [_window release];
    [_mainViewController release];
    [super dealloc];
}

@end
