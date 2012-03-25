//
//  logindata.h
//  beer
//
//  Created by Chris Griffith on 2/8/12.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

@interface logindata : UIViewController  <PF_FBRequestDelegate, NSURLConnectionDelegate>


- (void)logoutButtonTouchHandler:(id)sender;


@property (nonatomic, strong) IBOutlet UITextField *namefromfacebook;
@property (nonatomic, strong) IBOutlet UITextField *genderfromfacebook;
@property (nonatomic, strong) IBOutlet UITextField *birthdayfromfacebook;
@property (nonatomic, strong) IBOutlet UITextField *streetaddress;
@property (nonatomic, strong) IBOutlet UITextField *city;
@property (nonatomic, strong) IBOutlet UITextField *state;
@property (nonatomic, strong) IBOutlet UITextField *zipcode;
@property (nonatomic, strong) IBOutlet UITextField *email;

- (IBAction)loginbutton:(id)sender;
- (IBAction)signinbutton:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *ShippingScreen;

@property (weak, nonatomic) IBOutlet UIImageView *BeerBackground;

@end
//