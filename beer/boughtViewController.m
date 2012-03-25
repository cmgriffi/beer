//
//  boughtViewController.m
//  beer
//
//  Created by Chris Griffith on 3/17/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "boughtViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface boughtViewController ()

@end

@implementation boughtViewController
@synthesize BeerBackground;

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
    
    
    //making background more opaic
    BeerBackground.layer.opacity = .2;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
