//
//  beerViewController.m
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "beerViewController.h"

@implementation beerViewController
@synthesize scrolView;
// @synthesize picture;  **NOT SURE WHAT THIS IS.. it was giving me erros, so I commented it out and it seems to work now

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


    self.scrolView.contentSize = CGSizeMake(scrolView.frame.size.width*2, self.scrolView.frame.size.height);
// The above code is somthing to do with the size of the scroll window



}

- (void)viewDidUnload
{
    //[self setPicture:nil];   **NOT SURE WHAT THIS IS.. it was giving me erros, so I commented it out and it seems to work now
    
    [self setScrolView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

// semding tweets with tweet button

- (IBAction)tweetButton:(id)sender {
    
    
    if ([TWTweetComposeViewController canSendTweet]) {
        TWTweetComposeViewController *tweetComposer = [[TWTweetComposeViewController alloc] 
                                                       init];
        
        [tweetComposer setInitialText:@"This is my new favorite app!"];
        [self presentModalViewController:tweetComposer animated:YES];
    }
    
    else {
        UIAlertView *alertView = [[UIAlertView alloc]
                                  initWithTitle:@"Error" message:@"unable to send tweet." 
                                  delegate:self cancelButtonTitle:@"OK" otherButtonTitles:
                                  nil];
        [alertView show];
    }
    
// sending tweets with tweet button
    
}
@end
















