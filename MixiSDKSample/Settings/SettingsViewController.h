//
//  SettingsViewController.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SettingsViewControllerDelegate;

@interface SettingsViewController : UIViewController {
    IBOutlet UISegmentedControl *apiTypeSwitch_;
    IBOutlet UITextField *clientIdText_;
    IBOutlet UITextField *clientSecretText_;
    IBOutlet UITextView *scopesText_;
}

@property (nonatomic, assign) id <SettingsViewControllerDelegate> delegate;
@property (nonatomic, retain) UISegmentedControl *apiTypeSwitch;
@property (nonatomic, retain) UITextField *clientIdText;
@property (nonatomic, retain) UITextField *clientSecretText;
@property (nonatomic, retain) UITextView *scopesText;

- (IBAction)selectApiType:(id)sender;
- (IBAction)logout:(id)sender;
- (IBAction)revoke:(id)sender;
- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end


@protocol SettingsViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(SettingsViewController *)controller;
@end
