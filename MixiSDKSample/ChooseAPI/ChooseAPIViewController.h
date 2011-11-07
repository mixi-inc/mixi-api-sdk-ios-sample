//
//  ChooseAPIViewController.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MixiApi.h"

@protocol ChooseAPIViewControllerDelegate;

@interface ChooseAPIViewController : UIViewController<UIPickerViewDelegate, UIPickerViewDataSource> {
    id<ChooseAPIViewControllerDelegate> delegate_;
    MixiApi *currentApi_;
    IBOutlet UITextView *descriptionText_;
    IBOutlet UIPickerView *picker_;
}

@property (nonatomic, assign) id<ChooseAPIViewControllerDelegate> delegate;
@property (nonatomic, retain) MixiApi *currentApi;
@property (nonatomic, retain) UITextView *descriptionText;
@property (nonatomic, retain) UIPickerView *picker;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@protocol ChooseAPIViewControllerDelegate
@property (nonatomic, retain) MixiApi* currentApi;
@end