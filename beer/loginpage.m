//
//  loginpage.m
//  beer
//
//  Created by Chris Griffith on 2/4/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "loginpage.h"
//#import "beerAppDelegate.h"
#import "beerViewController.h"
#import "Parse/Parse.h"


@implementation loginpage
@synthesize activityIndicator;

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    // Check if user is cached and linked to Facebook, if so, bypass login    
    if ([PFUser currentUser] && [[PFUser currentUser] hasFacebook]) 
    {
        beerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"beerview"];
        [self.navigationController pushViewController:controller animated:YES];
    }
}



-(IBAction)login {
    PFObject *userlist = [PFObject objectWithClassName:@"userlist"];
    [userlist setObject:(firstname.text) forKey:@"FirstName"];
    [userlist setObject:(lastname.text) forKey:@"LastName"];
    [userlist setObject:(password.text) forKey:@"password"];
    [userlist setObject:(address.text) forKey:@"StreetAddress"];
    [userlist setObject:(city.text) forKey:@"City"];
    [userlist setObject:(state.text) forKey:@"State"];
    [userlist setObject:(zipcode.text) forKey:@"ZipCode"];
    [userlist save]; 
}

#pragma mark - Login mehtods


/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender 
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = [NSArray arrayWithObjects:@"user_about_me",@"user_relationships",@"user_birthday",@"user_location",@"offline_access", nil];
    
    // Login PFUser using facebook
    [PFUser logInWithFacebook:permissionsArray block:^(PFUser *user, NSError *error) 
     {
         //[activityIndicator stopAnimating]; // Hide loading indicator
         
         if (!user) {
             NSLog(@"Uh oh. The user cancelled the Facebook login.");
         } else if (user.isNew) {
             NSLog(@"User with facebook id %@ signed up and logged in!", user.facebookId);
             [self.navigationController pushViewController:[beerViewController alloc] animated:YES];
         } else {
             NSLog(@"User with facebook id %@ logged in!", user.facebookId);
            // [self presentModalViewController:beerViewController animated:YES]
             
             
             beerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"beerview"];
             [self.navigationController pushViewController:controller animated:YES];
             
         }
         
     }];
    
    //[activityIndicator startAnimating]; // Show loading indicator until login is finished
}



@end






//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
    //self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    //if (self) {
        // Custom initialization
    //}
  //  return self;
//}

//- (void)didReceiveMemoryWarning
//{
    // Releases the view if it doesn't have a superview.
  //  [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
//}

//#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/




//- (void)viewDidUnload
//{
  //  [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
//}

//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
//{
    // Return YES for supported orientations
//	return YES;
//}
















