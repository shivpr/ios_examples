//
//  RootViewController.m
//  Rotate
//
//  Created by Duane Cawthron on 6/7/12.
//  Copyright (c) 2012 Cawthron Consulting Services, Inc. All rights reserved.
//

#import "RootViewController.h"
#import "FixedViewController.h"
#import "RotatableViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)logAllSubviews:(UIView *)view withPrefix:(NSString *)prefix
{
    if (!prefix) prefix = @"";
    NSLog(@"%@%@ %@", prefix, view, NSStringFromCGRect(view.bounds));
    prefix = [prefix stringByAppendingString:@" "];
	for (UIView *eachView in [view subviews]) [self logAllSubviews:eachView withPrefix:prefix];
}

- (void)logAllSubviews:(UIView *)view
{
	[self logAllSubviews:view withPrefix:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
#pragma mark - fixed view
    
    FixedViewController *fixedViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"FixedViewController"];
    // instantiating from the storyboard enables calling some lifecycle methods
    
    fixedViewController.view.frame = self.view.window.bounds;
    // - (void)viewDidLoad
    
    fixedViewController.view.autoresizingMask = UIViewAutoresizingNone; // UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view.window addSubview:fixedViewController.view];
    [self.view.window sendSubviewToBack:fixedViewController.view];
    
    // these are called later in the run loop 
    // - (void)viewWillAppear:(BOOL)animated
    // - (void)viewDidLayoutSubviews
    // - (void)viewDidAppear:(BOOL)animated
    
    // these are NOT called
    // - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    // - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
    
    // these are called when the subview is touched (not the buttons)
    // View touchesBegan
    // NOTE: this one is NOT called, SubViewController touchesBegan
    // View touchesBegan
    // ViewController touchesBegan

#pragma mark - rotatable view
    
    RotatableViewController *rotatableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RotatableViewController"];
    rotatableViewController.view.frame = self.view.bounds;
    // - (void)viewDidLoad
    
    rotatableViewController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:rotatableViewController.view];
    
    [self addChildViewController:rotatableViewController];
    // - (void)willMoveToParentViewController:(UIViewController *)parent
    
    // NOTE addChildViewController: adds the SubViewController to the responder chain used to handle events
    
    [rotatableViewController didMoveToParentViewController:self];
    // - (void)didMoveToParentViewController:(UIViewController *)parent
    
    // these are called later in the run loop 
    // - (void)viewWillAppear:(BOOL)animated
    // - (void)viewDidLayoutSubviews
    // - (void)viewDidAppear:(BOOL)animated
    
    // these are called when the device is rotated
    // - (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
    // - (void)viewDidLayoutSubviews
    // - (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
    
    // these are called when the subview is touched (not the buttons)
    // View touchesBegan
    // SubViewController touchesBegan, this is called because SubViewController was added to the responder chain
    // View touchesBegan
    // ViewController touchesBegan
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self logAllSubviews:self.view.window];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;//(interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
