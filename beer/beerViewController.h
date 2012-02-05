//
//  beerViewController.h
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>
#import "Parse/Parse.h"

@interface beerViewController : UIViewController <PF_FBRequestDelegate, NSURLConnectionDelegate>




@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;





// tweet button

- (IBAction)tweetButton:(id)sender;

//tweet button


- (void)logoutButtonTouchHandler:(id)sender;





@end
