//
//  logindata.m
//  beer
//
//  Created by Chris Griffith on 2/8/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "logindata.h"
//#import "beerAppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "beerViewController.h"

@implementation logindata
@synthesize ShippingScreen;
@synthesize BeerBackground;
@synthesize namefromfacebook;
@synthesize genderfromfacebook;
@synthesize birthdayfromfacebook;
@synthesize streetaddress;
@synthesize city;
@synthesize state;
@synthesize zipcode;
@synthesize email;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    
    
    
    // Add logout navigation bar button
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonTouchHandler:)];
    [self.navigationItem setLeftBarButtonItem:logoutButton];
    
    
    
    
    //requesting data
    
    PF_Facebook *facebook = [PFUser facebook]; // Facebook object singleton
    // The graph api path for our request
    NSString *requestPath = [NSString stringWithFormat:
                             @"%@/?fields=first_name,location,gender,birthday,picture,email", 
                             [[PFUser currentUser] facebookId]];
    // The access token (the session)
    NSMutableDictionary *requestParameters = 
    [NSMutableDictionary dictionaryWithObject:[[PFUser currentUser] facebookAccessToken] 
                                       forKey:@"access_token"];
    // Execute the request
    [facebook requestWithGraphPath:requestPath 
                         andParams:requestParameters 
                       andDelegate:self];
    
    //adding shadow to the shipping info screen
    
    ShippingScreen.layer.masksToBounds = NO;
    ShippingScreen.layer.shadowOffset = CGSizeMake(10, 10);
    ShippingScreen.layer.shadowRadius = 5;
    ShippingScreen.layer.shadowOpacity = 2;
    ShippingScreen.layer.shadowPath = [UIBezierPath bezierPathWithRect:ShippingScreen.bounds].CGPath;
    
    //making background more opaic
    BeerBackground.layer.opacity = .5;
    
    
    
    
    
}
    
    
    
    
#pragma mark - Facebook Request Delegate methods
 
//This part request data from face book and puts it in texfields

    /* Callback delegate method for a successful graph request */
    -(void)request:(PF_FBRequest *)request didLoad:(id)result 
    {    
        // Parse the data received
        NSDictionary *userData = (NSDictionary *)result;
        NSString *name = [userData objectForKey:@"first_name"];
        NSString *location = [[userData objectForKey:@"location"] objectForKey:@"name"];
        NSString *gender = [userData objectForKey:@"gender"];
        NSString *birthday = [userData objectForKey:@"birthday"];
        NSString *emailaddress = [userData objectForKey:@"email"];
    
        
        NSArray* foo = [location componentsSeparatedByString: @","];
        NSString* cityfb = [foo objectAtIndex: 0];
        NSString* statefb =[foo objectAtIndex:1];
        
        [namefromfacebook setText:name];
        [genderfromfacebook setText:gender];
        
        [birthdayfromfacebook setText:birthday];
        [email setText:emailaddress];
        [city setText:cityfb];
        [state setText:statefb];
        
        
        
    }
 
//This part signs users up with the facebook data received. need to figure out how to combine data
    
- (void)loginbutton:(id)sender {
    PFUser *user = [PFUser currentUser];
    //user.username = namefromfacebook.text;
    //user.password = @"my pass";
    //user.email = email.text;
    
          // other fields can be set just like with PFObjecr];
    [user setObject:streetaddress.text forKey:@"streetaddress"];
    [user setObject:(city.text) forKey:@"city"];
    [user setObject:(state.text) forKey:@"state"];
    [user setObject:(zipcode.text) forKey:@"zipcode"];
    [user setObject:(email.text) forKey:@"email"];
    [user save];
    
   
//Validating the user filled in all info
    // Check to see if it's blank
    if([namefromfacebook.text isEqualToString:@""]) {
        // There's no text in the box.
        
        UIAlertView *namemessage = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                          message:@"Please Fill Out Your Name!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        
        [namemessage show];
    }else if([streetaddress.text isEqualToString:@""]){
        UIAlertView *streetaddressnmessage = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                          message:@"Please out your Address!"
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [streetaddressnmessage show];
    
    }else if([city.text isEqualToString:@""]){
        UIAlertView *citymessage = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                                        message:@"Please out your City!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [citymessage show];
        
    }else if([state.text isEqualToString:@""]){
        UIAlertView *statemessage = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                                        message:@"Please out your state!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [statemessage show];
        
    }else if([zipcode.text isEqualToString:@""]){
        UIAlertView *zipcodemessage = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                                        message:@"Please out your ZIP!"
                                                                       delegate:nil
                                                              cancelButtonTitle:@"OK"
                                                              otherButtonTitles:nil];
        [zipcodemessage show];
        
    }



    
    
    // Check to see if it's NOT blank
    if(![namefromfacebook.text isEqualToString:@""]) {
    if(![genderfromfacebook.text isEqualToString:@""]) {
    if(![streetaddress.text isEqualToString:@""]) {
    if(![city.text isEqualToString:@""]) {
    if(![state.text isEqualToString:@""]) {
    if(![zipcode.text isEqualToString:@""]) {
        // There's text in the box.
        logindata *controller2 = [self.storyboard instantiateViewControllerWithIdentifier:@"beerview"];
        [self.navigationController pushViewController:controller2 animated:YES];
    }}}}}}}
    
// DONE VALIDATING
    
  /*  
  [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // Hooray! Let them use the app now.
            
            // this will take you to the beerviewcontroller view when unique data is entered. need to figure out how 
          beerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"beerview"];
          [self.navigationController pushViewController:controller animated:YES];
            
      } else {
          NSString *errorString = [[error userInfo] objectForKey:@"error"];
            // Show the errorString somewhere and let the user try again.
          UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Rut Roh"
                                                           message:errorString
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            
          [message show];
            
        
            
      }
  }];
   */










    
//Sign in code once you have signed up

- (void)signinbutton:(id)sender {
    [PFUser logInWithUsernameInBackground:namefromfacebook.text password:@"my pass"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // do stuff after successful login.
                                            NSLog(@"signup success");
                                            beerViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"beerview"];
                                            [self.navigationController pushViewController:controller animated:YES];
                                            
                                        } else {
                                            // the username or password is invalid. 
                                            NSLog(@"signup fail");
                                            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Rut Roh!"
                                                                                              message:@"Please Create an Account"
                                                                                             delegate:nil
                                                                                    cancelButtonTitle:@"OK"
                                                                                    otherButtonTitles:nil];
                                            
                                            [message show];
                                        }
                                    }];
}
    
    
    
    
    
    
    
  //  [super viewDidLoad];
//}


- (void)viewDidUnload
{
    [self setShippingScreen:nil];
    [self setBeerBackground:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}



- (void)logoutButtonTouchHandler:(id)sender 
{
    // Logout user, this automatically clears the cache
    [PFUser logOut];
    
    //Return to login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];    
}



@end
