//
//  MixiSDKSampleAppDelegate.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RequestViewController;

@interface MixiSDKSampleAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet RequestViewController *mainViewController;

@end
