//
//  EditBodyViewController.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "EditBodyViewController.h"


@implementation EditBodyViewController

@synthesize delegate=delegate_, 
    descriptionView=descriptionView_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.descriptionView becomeFirstResponder];
    if (self.delegate) {
        self.descriptionView.text = self.delegate.parameters;
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.descriptionView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Actions

- (IBAction)done:(id)sender {
    if (self.delegate) {
        self.delegate.parameters = self.descriptionView.text;
    }
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
