//
//  EditBodyViewController.h
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EditBodyViewControllerDelegate;


@interface EditBodyViewController : UIViewController {
    id<EditBodyViewControllerDelegate> delegate_;
    IBOutlet UITextView *descriptionView_;
}

@property (nonatomic, assign) id<EditBodyViewControllerDelegate> delegate;
@property (nonatomic, retain) UITextView *descriptionView;

- (IBAction)done:(id)sender;
- (IBAction)cancel:(id)sender;

@end

@protocol EditBodyViewControllerDelegate
@property (nonatomic, assign) NSString *parameters;
@end