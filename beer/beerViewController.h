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
#import "CorePlot-CocoaTouch.h"

int counter;
int likecounter;
int mehcounter;
int hatecounter;



@interface beerViewController : UIViewController <PF_FBRequestDelegate, NSURLConnectionDelegate, CPTBarPlotDataSource, CPTBarPlotDelegate>

//graph stuff
@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;
@property (weak, nonatomic) IBOutlet UILabel *count;
@property (weak, nonatomic) IBOutlet UILabel *likecount;
@property (weak, nonatomic) IBOutlet UILabel *mehcount;
@property (weak, nonatomic) IBOutlet UILabel *hatecount;
@property (weak, nonatomic) IBOutlet UIImageView *BeerBackground2;



-(IBAction)loverate:(id)sender;
-(IBAction)likerate:(id)sender;
-(IBAction)mehrate:(id)sender;
-(IBAction)haterate:(id)sender;
-(IBAction)beermenu:(id)sender;



- (void)generateBarPlot;
//graph stuff





@property (weak, nonatomic) IBOutlet UIScrollView *scrolView;





// tweet button

- (IBAction)tweetButton:(id)sender;

//tweet button


- (void)logoutButtonTouchHandler:(id)sender;


-(IBAction)graphbutton:(id)sender;






@end
