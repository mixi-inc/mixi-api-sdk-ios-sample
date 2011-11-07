//
//  RequestViewController.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "RequestViewController.h"
#import "MixiApi.h"
#import "Config.h"
#import "ChooseAPIViewController.h"
#import "EditBodyViewController.h"
#import "SBJson.h"

@implementation RequestViewController

@synthesize currentApi=currentApi_,
    endpointText=endpointText_,
    methodSwitch=methodSwitch_,
    imageSwitch=imageSwitch_,
    paramsText=paramsText_;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.currentApi = [[MixiApi all] objectAtIndex:0];
}

- (void)flipsideViewControllerDidFinish:(SettingsViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.endpointText = nil;
    self.methodSwitch = nil;
    self.imageSwitch = nil;
    self.paramsText = nil;
}

- (void)dealloc
{
    self.currentApi = nil;
    [super dealloc];
}

#pragma mark - Getter/Setter

- (void)setCurrentApi:(MixiApi*)api {
    if (currentApi_) {
        if ([currentApi_ isEqual:api]) {
            return;
        }
        [currentApi_ release];
    }
    currentApi_ = [api retain];
    self.endpointText.text = self.currentApi.endpoint;
    self.methodSwitch.selectedSegmentIndex = [self.currentApi isGetMethod] ? 0 : 1;
    self.imageSwitch.on = self.currentApi.imageAdded;
    self.paramsText.text = self.currentApi.params;
}

- (void)setParameters:(NSString *)parameters {
    self.paramsText.text = parameters;
}

- (NSString*)parameters {
    return self.paramsText.text;
}

#pragma mark -

- (MixiRequest*)buildRequest {
    NSString *endpoint = self.endpointText.text;
    NSString *method = self.methodSwitch.selectedSegmentIndex == 0 ? @"GET" : @"POST";
    MixiRequest *request;
    
    if ([endpoint hasPrefix:@"/photo/mediaItems/"]) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"mixi_map_logo" ofType:@"png"];
        UIImage *image = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
        request = [MixiRequest postRequestWithEndpoint:endpoint
                                                  body:image
                                         paramsAndKeys:self.paramsText.text, @"title", nil];
    }
    else {
        request = [MixiRequest requestWithMethod:method endpoint:endpoint];
        if ([self.paramsText.text hasPrefix:@"{"]) {
            // JSON
            [request clearParams];
            NSDictionary *json = [self.paramsText.text JSONValue];
            [request setParam:json forKey:@"request"];
        }
        else {
            // Form
            [request clearParams];
            if (self.paramsText.text != nil && ![self.paramsText.text isEqualToString:@""]) {
                NSArray *params = [self.paramsText.text componentsSeparatedByString:@"\n"];
                for (NSString *param in params) {
                    NSArray *pair = [param componentsSeparatedByString:@"="];
                    if ([pair count] == 2) {
                        [request setParam:[pair objectAtIndex:1]
                                   forKey:[pair objectAtIndex:0]];
                    }
                }
            }
        }
        if ([imageSwitch_ isOn]) {
            NSString *path = [[NSBundle mainBundle] pathForResource:@"mixi_map_logo" ofType:@"gif"];
            UIImage *image = [[[UIImage alloc] initWithContentsOfFile:path] autorelease];
            [request addAttachment:image forKey:@"photo"];
        }
    }
    return request;
}

#pragma mark - Actions

- (IBAction)selectAPI:(id)sender {
    ChooseAPIViewController *controller = [[ChooseAPIViewController alloc] initWithNibName:@"ChooseAPIViewController" bundle:nil];
    controller.delegate = self;
    [self presentModalViewController:controller animated:YES];
    [controller release];    
}

- (IBAction)editParams:(id)sender {
    EditBodyViewController *controller = [[EditBodyViewController alloc] initWithNibName:@"EditBodyViewController" bundle:nil];
    controller.delegate = self;
    [self presentModalViewController:controller animated:YES];
    [controller release];
}

- (IBAction)call:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    NSString *scopes = mixi.config.selectorType == kMixiApiTypeSelectorMixiApp ? kMixiAppliScopes : kMixiGraphScopes;
    if ([mixi isAuthorized]) {
        MixiRequest *request = [self buildRequest];
        if ([request.endpoint hasPrefix:@"/dialog/"]) {
            MixiViewController *mixiViewController = [mixi buildViewControllerWithRequest:request delegate:self];
            [self presentModalViewController:mixiViewController animated:YES];
        }
        else {
            [mixi sendRequest:request delegate:self];
        }
    }
    else if (![mixi authorizeForPermission:scopes]) {
        MixiWebViewController *vc = MixiUtilDownloadViewController(self, @selector(closeDownloadView));
        [self presentModalViewController:vc animated:YES];
    }
}

- (IBAction)showInfo:(id)sender
{    
    SettingsViewController *controller = [[SettingsViewController alloc] initWithNibName:@"SettingsView" bundle:nil];
    controller.delegate = self;
    
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
    
    [controller release];
}

- (IBAction)closeKeyboard:(id)sender {
    [sender resignFirstResponder];
}

#pragma mark - MixiDelegate

- (void)mixi:(Mixi*)mixi didFinishLoading:(NSString*)data {
    [[[[UIAlertView alloc]
       initWithTitle:@"API実行結果"
       message:data
       delegate:nil
       cancelButtonTitle:nil
       otherButtonTitles:@"OK", nil
       ] autorelease] show];
}

- (void)mixi:(Mixi*)mixi didFailWithConnection:(NSURLConnection*)connection error:(NSError*)error {
    [[[[UIAlertView alloc]
       initWithTitle:@"API実行失敗"
       message:[error description]
       delegate:nil
       cancelButtonTitle:nil
       otherButtonTitles:@"OK", nil
       ] autorelease] show];
}

- (void)mixi:(Mixi*)mixi didFailWithError:(NSError*)error {
    [[[[UIAlertView alloc]
       initWithTitle:@"API実行失敗"
       message:[error description]
       delegate:nil
       cancelButtonTitle:nil
       otherButtonTitles:@"OK", nil
       ] autorelease] show];    
}


- (void)closeDownloadView {
    [self dismissModalViewControllerAnimated:YES];
}

@end
