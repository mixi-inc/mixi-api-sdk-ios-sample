//
//  RequestViewController.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "SettingsViewController.h"
#import "MixiSDK.h"
#import "ChooseAPIViewController.h"
#import "EditBodyViewController.h"

@class MixiApi;

@interface RequestViewController : UIViewController <SettingsViewControllerDelegate, MixiDelegate, ChooseAPIViewControllerDelegate, EditBodyViewControllerDelegate> {
    MixiApi *currentApi_;
    IBOutlet UITextField *endpointText_;
    IBOutlet UISegmentedControl *methodSwitch_;
    IBOutlet UISwitch *imageSwitch_;
    IBOutlet UITextView *paramsText_;
}

@property (nonatomic, retain) MixiApi *currentApi;
@property (nonatomic, retain) UITextField *endpointText;
@property (nonatomic, retain) UISegmentedControl *methodSwitch;
@property (nonatomic, retain) UISwitch *imageSwitch;
@property (nonatomic, retain) UITextView *paramsText;
@property (nonatomic, assign) NSString *parameters;

- (IBAction)selectAPI:(id)sender;
- (IBAction)editParams:(id)sender;
- (IBAction)call:(id)sender;
- (IBAction)showInfo:(id)sender;
- (IBAction)closeKeyboard:(id)sender;

@end
