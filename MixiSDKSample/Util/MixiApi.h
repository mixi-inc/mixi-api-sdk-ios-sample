//
//  MixiApi.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/05.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MixiSDK.h"

@interface MixiApi : NSObject {
    NSString *label_;
    MixiApiType apiType_;
    NSString *endpoint_;
    NSString *method_;
    BOOL imageAdded_;
    NSString *params_;
    NSString *description_;
}

@property (nonatomic, copy) NSString *label;
@property (nonatomic, assign) MixiApiType apiType;
@property (nonatomic, copy) NSString *endpoint;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, assign) BOOL imageAdded;
@property (nonatomic, copy) NSString *params;
@property (nonatomic, copy) NSString *description;

+ (void)setGraph;
+ (void)setAppli;
+ (NSArray*)all;
+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params image:(BOOL)imageAdded description:(NSString*)description;
+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params description:(NSString*)description;
+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method description:(NSString*)description;
- (id)initWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params image:(BOOL)imageAdded description:(NSString*)description;
- (BOOL)isGetMethod;
- (BOOL)isPostMethod;

@end
