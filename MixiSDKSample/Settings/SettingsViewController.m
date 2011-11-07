//
//  SettingsViewController.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import "MixiSDK.h"
#import "MixiApi.h"
#import "Config.h"

@interface SettingsViewController ()
- (void)updateWithMixi:(Mixi*)mixi;
@end

@implementation SettingsViewController

@synthesize delegate=_delegate,
    apiTypeSwitch=apiTypeSwitch_,
    clientIdText=clientIdText_,
    clientSecretText=clientSecretText_,
    scopesText=scopesText_;

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor viewFlipsideBackgroundColor];  
    Mixi *mixi = [Mixi sharedMixi];
    if (mixi.config.selectorType == kMixiApiTypeSelectorMixiApp) {
        self.apiTypeSwitch.selectedSegmentIndex = 0;
        self.scopesText.text = kMixiAppliScopes;
    }
    else {
        self.apiTypeSwitch.selectedSegmentIndex = 1;        
        self.scopesText.text = kMixiGraphScopes;
    }
    self.clientIdText.text = mixi.config.clientId;
    self.clientSecretText.text = mixi.config.secret;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.apiTypeSwitch = nil;
    self.clientIdText = nil;
    self.clientSecretText = nil;
    self.scopesText = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -

- (void)updateWithMixi:(Mixi*)mixi {
}

#pragma mark - Actions

- (IBAction)selectApiType:(id)sender {
    UISegmentedControl *swtch = (UISegmentedControl*)sender;
    Mixi *mixi = [Mixi sharedMixi];
    if (swtch.selectedSegmentIndex == 0) {
        [mixi setupWithType:kMixiApiTypeSelectorMixiApp clientId:kMixiAppliClientId secret:kMixiAppliClientSecret appId:kAppId];
        [MixiApi setAppli];
    }
    else {
        [mixi setupWithType:kMixiApiTypeSelectorGraphApi clientId:kMixiGraphClientId secret:kMixiGraphClientSecret appId:kAppId];
        [MixiApi setGraph];
    }
    self.clientIdText.text = mixi.config.clientId;
    self.clientSecretText.text = mixi.config.secret;
    self.scopesText.text = mixi.config.selectorType == kMixiApiTypeSelectorMixiApp ? kMixiAppliScopes: kMixiGraphScopes;
}

- (IBAction)logout:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    [mixi logout];    
}

- (IBAction)revoke:(id)sender {
    Mixi *mixi = [Mixi sharedMixi];
    [mixi revoke];
}

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)cancel:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end
