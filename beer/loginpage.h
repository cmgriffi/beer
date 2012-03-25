//
//  loginpage.h
//  beer
//
//  Created by Chris Griffith on 2/4/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface loginpage : UIViewController {
    
    IBOutlet UITextField *firstname;
    IBOutlet UITextField *lastname;
    IBOutlet UITextField *password;
    IBOutlet UITextField *address;
    IBOutlet UITextField *city;
    IBOutlet UITextField *state;
    IBOutlet UITextField *zipcode;
    
}

//@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *activityIndicator;


-(IBAction)login;




-(IBAction)loginButtonTouchHandler:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *shadowtest;

@end
