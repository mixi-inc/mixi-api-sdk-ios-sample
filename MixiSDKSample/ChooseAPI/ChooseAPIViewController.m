//
//  ChooseAPIViewController.m
//  MixiSDKSample
//
//  Created by yasushi.ando on 11/10/04.
//  Copyright 2011 mixi Inc. All rights reserved.
//

#import "ChooseAPIViewController.h"

static NSArray *apis;

@implementation ChooseAPIViewController

@synthesize delegate=delegate_,
    currentApi=currentApi_,
    descriptionText=descriptionText_,
    picker=picker_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        if (!apis) {
            apis = [NSArray arrayWithObjects:@"People", nil];
        }
    }
    return self;
}

- (void)dealloc
{
    self.currentApi = nil;
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
    if (self.delegate) {
        self.currentApi = self.delegate.currentApi;
    }
}

- (void)setCurrentApi:(MixiApi*)currentApi {
    if (self.currentApi) {
        if ([self.currentApi isEqual:currentApi]) {
            return;
        }
        [self.currentApi release];
    }
    currentApi_ = [currentApi retain];
    if (!currentApi) return;
    
    int row = 0;
    NSArray *apis = [MixiApi all];
    for (int i = 0; i < [apis count]; i++) {
        MixiApi *api = [apis objectAtIndex:i];
        if ([api.label isEqualToString:currentApi.label]) {
            row = i;
        }
    }
    [self.picker selectRow:row inComponent:0 animated:YES];
    self.descriptionText.text = currentApi.description;    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.descriptionText = nil;
    self.picker = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [[MixiApi all] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[[MixiApi all] objectAtIndex:row] label];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.currentApi = (MixiApi*)[[MixiApi all] objectAtIndex:row];
}

#pragma mark - Actions

- (IBAction)done:(id)sender {
    if (self.delegate) {
        self.delegate.currentApi = self.currentApi;
    }
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (IBAction)cancel:(id)sender {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

@end
