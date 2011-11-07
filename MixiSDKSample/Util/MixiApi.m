//
//  MixiApi.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/05.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "MixiApi.h"


@implementation MixiApi

static NSArray *allAppli;
static NSArray *allGraph;
static BOOL isGraph = YES;

@synthesize label=label_,
    apiType=apiType_,
    endpoint=endpoint_,
    method=method_,
    imageAdded=imageAdded_,
    params=params_,
    description=description_;

+ (void)setGraph {
    isGraph = YES;
}

+ (void)setAppli {
    isGraph = NO;
}

+ (NSArray*)all {
    if (isGraph) {
        if (allGraph) return allGraph;
        allGraph = [[NSArray arrayWithObjects:
                     [self apiWithLabel:@"People: 友人一覧の取得" 
                                   type:kMixiApiTypeSelectorGraphApi 
                               endpoint:@"/people/@me/@friends"
                                 method:@"GET" 
                                 params:@"sortBy=displayName" 
                            description:@"友人一覧を検索します。"],
                     [self apiWithLabel:@"Voice: つぶやきの投稿" 
                                   type:kMixiApiTypeSelectorGraphApi 
                               endpoint:@"/voice/statuses/update"
                                 method:@"POST" 
                                 params:@"status=こんにちはこんにちは" 
                            description:@"つぶやきを投稿します。"],
                     nil] retain];
        return allGraph;
    }
    else {
        if (allAppli) return allAppli;
        allAppli = [[NSArray arrayWithObjects:
                     [self apiWithLabel:@"People: 友人一覧の取得" 
                                   type:kMixiApiTypeSelectorMixiApp 
                               endpoint:@"/people/@me/@friends"
                                 method:@"GET" 
                                 params:@"sortBy=displayName" 
                            description:@"友人一覧を検索します。"],
                     [self apiWithLabel:@"Photo: アルバム一覧の取得" 
                                   type:kMixiApiTypeSelectorMixiApp 
                               endpoint:@"/photo/albums/@me/@self"
                                 method:@"POST" 
                            description:@"アルバム一覧を取得します。"],
                     [self apiWithLabel:@"Photo: フォトの追加" 
                                   type:kMixiApiTypeSelectorMixiApp 
                               endpoint:@"/photo/mediaItems/@me/@self/@default"
                                 method:@"POST" 
                                 params:@"写真のタイトル"
                                  image:YES
                            description:@"画像をデフォルトアルバムに投稿します。本API呼び出しのパラメータは変更できません。"],
                     nil] retain];
        return allAppli;        
    }
}

+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params image:(BOOL)imageAdded description:(NSString*)description {
    return [[self alloc] initWithLabel:label type:apiType endpoint:endpoint method:method params:@"" image:imageAdded description:description];    
}

+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method description:(NSString*)description {
    return [[self alloc] initWithLabel:label type:apiType endpoint:endpoint method:method params:@"" image:NO description:description];
}

+ (id)apiWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params description:(NSString*)description {
    return [[self alloc] initWithLabel:label type:apiType endpoint:endpoint method:method params:params image:NO description:description];
}

- (id)initWithLabel:(NSString*)label type:(MixiApiType)apiType endpoint:(NSString*)endpoint method:(NSString*)method params:(NSString*)params image:(BOOL)imageAdded description:(NSString*)description {
    if ((self = [super init])) {
        self.label = label;
        self.apiType = apiType;
        self.endpoint = endpoint;
        self.method = method;
        self.params = params;
        self.imageAdded = imageAdded;
        self.description = description;
    }
    return self;
}

- (BOOL)isGetMethod {
    return [self.method isEqualToString:@"GET"];
}

- (BOOL)isPostMethod {
    return ![self isGetMethod];
}

- (void)dealloc {
    self.label = nil;
    self.endpoint = nil;
    self.method = nil;
    self.params = nil;
    self.description = nil;
    [super dealloc];
}

@end
