//
//  beerViewController.m
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "beerViewController.h"
#import "beerAppDelegate.h"

@implementation beerViewController
@synthesize webPage;
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
    
    //This is the code for launching the web page
    [webPage loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://twitter.com/#!/search/beer"]]];
    
    //This is the code for launching the web page
    
    
// This is sample code the saves data to parse.com DB - Code is functional but does nothing in the app    
    
    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
    [testObject setObject:@"Chris" forKey:@"Name"];
    [testObject save]; 
    
// This is sample code the saves data to parse.com DB - Code is functional but does nothing in the app   
    
    
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.


// This code controls the scrolling of the pictures in the top left
    
    self.scrolView.contentSize = CGSizeMake(scrolView.frame.size.width*2, self.scrolView.frame.size.height);
// This code controls the scrolling of the pictures in the top left

    
    


}

- (void)viewDidUnload
{
    //[self setPicture:nil];   **NOT SURE WHAT THIS IS.. it was giving me erros, so I commented it out and it seems to work now
    
    [self setScrolView:nil];
    [self setWebPage:nil];
    
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
















