//
//  beerViewController.h
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Twitter/Twitter.h>

@interface beerViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;





// tweet button

- (IBAction)tweetButton:(id)sender;

//tweet button



//web page
@property (weak, nonatomic) IBOutlet UIWebView *webPage;
//web page





@end
