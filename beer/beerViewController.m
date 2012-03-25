//
//  beerViewController.m
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import "beerViewController.h"
#import "beerAppDelegate.h"
#import "MyTableController.h"




@implementation beerViewController;

@synthesize count;
@synthesize likecount;
@synthesize mehcount;
@synthesize hatecount;
@synthesize scrolView;
@synthesize BeerBackground2;


// @synthesize picture;  **NOT SURE WHAT THIS IS.. it was giving me erros, so I commented it out and it seems to work now



//graph stuff
#define BAR_POSITION @"POSITION"
#define BAR_HEIGHT @"HEIGHT"
#define COLOR @"COLOR"
#define CATEGORY @"CATEGORY"

#define AXIS_START 0
#define AXIS_END 50

@synthesize data;
@synthesize graph;
@synthesize hostingView;





//graph stuff



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    
    //pulling rating data from parse 
    
    PFQuery *query = [ PFQuery queryWithClassName:@"graph"];
    PFObject *lovescore = [query getObjectWithId:@"aP1C2cCFhY"];
    int lovedisplay = [[lovescore objectForKey:@"love"] intValue];
    int likedisplay = [[lovescore objectForKey:@"like"] intValue];
    int mehdisplay = [[lovescore objectForKey:@"meh"] intValue];
    int hatedisplay = [[lovescore objectForKey:@"hate"] intValue];
    
    
    
 
   
    //pulling rating data from parse
    
    //converting int to string
    NSString *lovestring = [NSString stringWithFormat:@"%i", lovedisplay];
    NSString *likestring = [NSString stringWithFormat:@"%i", likedisplay];
    NSString *mehstring = [NSString stringWithFormat:@"%i", mehdisplay];
    NSString *hatestring = [NSString stringWithFormat:@"%i", hatedisplay];
    
    
    
    //setting initail rating values
    [count setText:lovestring];
    [likecount setText:likestring];
    [mehcount setText:mehstring];
    [hatecount setText:hatestring];
    
    
    
    // Add logout navigation bar button
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonTouchHandler:)];
    [self.navigationItem setLeftBarButtonItem:logoutButton];
    
    
    
    //making background more opaic
    BeerBackground2.layer.opacity = .2;
    
    
// picture upload
    
//    UIImage *beerpicture = [UIImage imageNamed:@"picture.jpg"];
    
    
//    NSData *imageData = UIImagePNGRepresentation(beerpicture);
//    PFFile *imageFile = [PFFile fileWithName:@"picture.jpg" data:imageData];
//    [imageFile save];
    
//    PFObject *userPhoto = [PFObject objectWithClassName:@"UserPhoto"];
//    [userPhoto setObject:@"testing" forKey:@"imageName"];
//    [userPhoto setObject:imageFile             forKey:@"imageFile"];
//    [userPhoto saveInBackground];
    
// picture upload
    
  
    //graph stuff
    
 
    
    
    if (self) {
        
        self.data = [NSMutableArray array];
        
        int bar_heights[] = {lovedisplay,likedisplay,mehdisplay,hatedisplay};
        UIColor *colors[] = {
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor purpleColor]};
        NSString *categories[] = {@"LOVE IT", @"LIKE IT", @"MEH", @"HATE IT"};
        
        for (int i = 0; i < 4 ; i++){
            double position = i*10; //Bars will be 10 pts away from each other
            double height = bar_heights[i];
            
            NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithDouble:position],BAR_POSITION,
                                 [NSNumber numberWithDouble:height],BAR_HEIGHT,
                                 colors[i],COLOR,
                                 categories[i],CATEGORY,
                                 nil];
            [self.data addObject:bar];
            
        }
        [self generateBarPlot];
    }
//graph stuff
    
    
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    
    
    
    

// This code controls the scrolling of the pictures in the top left
    
    self.scrolView.contentSize = CGSizeMake(scrolView.frame.size.width*2, self.scrolView.frame.size.height);
// This code controls the scrolling of the pictures in the top left

    
    


}



- (void)generateBarPlot
{
    
    //Create host view
    self.hostingView = [[CPTGraphHostingView alloc] 
                        initWithFrame:[[UIScreen mainScreen]bounds]];
    [self.view addSubview:self.hostingView];
    
    
    //Create graph and set it as host view's graph
    self.graph = [[CPTXYGraph alloc] initWithFrame:self.hostingView.bounds];
    [self.hostingView setHostedGraph:self.graph];
    [self.hostingView setFrame:CGRectMake(390, 60, 350, 400)];
    
    
    //set graph padding and theme
    self.graph.plotAreaFrame.paddingTop = 20.0f;
    self.graph.plotAreaFrame.paddingRight = 20.0f;
    self.graph.plotAreaFrame.paddingBottom = 20.0f;
    self.graph.plotAreaFrame.paddingLeft = 70.0f;
  //  [self.graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    
    //set axes ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)self.graph.defaultPlotSpace;
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:
                        CPTDecimalFromFloat(AXIS_START)
                                                    length:CPTDecimalFromFloat((AXIS_END - AXIS_START)+5)];
    
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)self.graph.axisSet;
    //set axes' title, labels and their text styles
    CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
    textStyle.fontName = @"Helvetica";
    textStyle.fontSize = 14;
    textStyle.color = [CPTColor blackColor];
   // axisSet.xAxis.title = @"BEER RATING";
    //axisSet.yAxis.title = @"COUNT";
    axisSet.xAxis.titleTextStyle = textStyle;
    axisSet.yAxis.titleTextStyle = textStyle;
    axisSet.xAxis.titleOffset = 30.0f;
    axisSet.yAxis.titleOffset = 40.0f;
    axisSet.xAxis.labelTextStyle = textStyle;
    axisSet.xAxis.labelOffset = 3.0f;
    axisSet.yAxis.labelTextStyle = textStyle;
    axisSet.yAxis.labelOffset = 3.0f;
    //set axes' line styles and interval ticks
    CPTMutableLineStyle *lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.lineColor = [CPTColor blackColor];
    lineStyle.lineWidth = 1.0f;
    axisSet.xAxis.axisLineStyle = lineStyle;
    axisSet.yAxis.axisLineStyle = lineStyle;
    axisSet.xAxis.majorTickLineStyle = lineStyle;
    axisSet.yAxis.majorTickLineStyle = lineStyle;
    axisSet.xAxis.majorIntervalLength = CPTDecimalFromFloat(0.0f);
    axisSet.yAxis.majorIntervalLength = CPTDecimalFromFloat(15.0f);
    axisSet.xAxis.majorTickLength = 7.0f;
    axisSet.yAxis.majorTickLength = 7.0f;
    axisSet.xAxis.minorTickLineStyle = lineStyle;
    axisSet.yAxis.minorTickLineStyle = lineStyle;
    axisSet.xAxis.minorTicksPerInterval = 1;
    axisSet.yAxis.minorTicksPerInterval = 1;
    axisSet.xAxis.minorTickLength = 5.0f;
    axisSet.yAxis.minorTickLength = 5.0f;
    
    // Create bar plot and add it to the graph
    CPTBarPlot *plot = [[CPTBarPlot alloc] init] ;
    plot.dataSource = self;
    plot.delegate = self;
    plot.barWidth = [[NSDecimalNumber decimalNumberWithString:@"6.0"]
                     decimalValue];
    plot.barOffset = [[NSDecimalNumber decimalNumberWithString:@"10.0"]
                      decimalValue];
    plot.barCornerRadius = 5.0;
    // Remove bar outlines
    CPTMutableLineStyle *borderLineStyle = [CPTMutableLineStyle lineStyle];
    borderLineStyle.lineColor = [CPTColor clearColor];
    plot.lineStyle = borderLineStyle;
    // Identifiers are handy if you want multiple plots in one graph
    plot.identifier = @"chocoplot";
    [self.graph addPlot:plot];
    //[plot release];
    
    
    
}




-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ( [plot.identifier isEqual:@"chocoplot"] )
        return [self.data count];
    
    return 0;
}



-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    if ( [plot.identifier isEqual:@"chocoplot"] )
    {
        NSDictionary *bar = [self.data objectAtIndex:index];
        
        if(fieldEnum == CPTBarPlotFieldBarLocation)
            return [bar valueForKey:BAR_POSITION];
        else if(fieldEnum ==CPTBarPlotFieldBarTip)
            return [bar valueForKey:BAR_HEIGHT];
    }
    return [NSNumber numberWithFloat:0];
}


-(CPTLayer *)dataLabelForPlot:(CPTPlot *)plot recordIndex:(NSUInteger)index
{
    if ( [plot.identifier isEqual: @"chocoplot"] )
    {
        CPTMutableTextStyle *textStyle = [CPTMutableTextStyle textStyle];
        textStyle.fontName = @"Helvetica";
        textStyle.fontSize = 14;
        textStyle.color = [CPTColor blackColor];
        
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTTextLayer *label = [[CPTTextLayer alloc] initWithText:[NSString stringWithFormat:@"%@", [bar valueForKey:@"CATEGORY"]]];
        label.textStyle =textStyle;
        
        return label;
    }
    
    CPTTextLayer *defaultLabel = [[CPTTextLayer alloc] initWithText:[NSString stringWithString:@"Label"]];
    return defaultLabel;
    
}

-(CPTFill *)barFillForBarPlot:(CPTBarPlot *)barPlot
                  recordIndex:(NSUInteger)index
{
    if ( [barPlot.identifier isEqual:@"chocoplot"] )
    {
        NSDictionary *bar = [self.data objectAtIndex:index];
        CPTGradient *gradient = [CPTGradient gradientWithBeginningColor:[CPTColor whiteColor]
                                                            endingColor:[bar valueForKey:@"COLOR"]
                                                      beginningPosition:0.0 endingPosition:0.2 ];
        [gradient setGradientType:CPTGradientTypeAxial];
        [gradient setAngle:320.0]; 
        
        CPTFill *fill = [CPTFill fillWithGradient:gradient];
        
        return fill;
        
    }
    return [CPTFill fillWithColor:[CPTColor colorWithComponentRed:1.0 green:1.0 blue:1.0 alpha:1.0]];
    
}



//end of graph stuff


-(IBAction)beermenu:(id)sender{
    
        
    MyTableController *controller4 = [[MyTableController alloc] init];
    [self.storyboard instantiateViewControllerWithIdentifier:@"beertable"];
    [self.navigationController pushViewController:controller4 animated:YES];
    
}


-(IBAction)loverate:(id)sender{
    
    
    //pulling rating data from parse 
    
    PFQuery *query = [ PFQuery queryWithClassName:@"graph"];
    PFObject *lovescore = [query getObjectWithId:@"aP1C2cCFhY"];
    int lovedisplay = [[lovescore objectForKey:@"love"] intValue];
    int likedisplay = [[lovescore objectForKey:@"like"] intValue];
    int mehdisplay = [[lovescore objectForKey:@"meh"] intValue];
    int hatedisplay = [[lovescore objectForKey:@"hate"] intValue];
    
    
    
    [lovescore incrementKey:@"love" byAmount:[NSNumber numberWithInt:1]];
    [lovescore saveInBackground];
    
    
    //converting to a string
    
    NSString *lovestring = [NSString stringWithFormat:@"%i", lovedisplay+1];
   
    [count setText:lovestring];
  
    
    
    if (self) {
        
        self.data = [NSMutableArray array];
        
        int bar_heights[] = {lovedisplay+1,likedisplay,mehdisplay,hatedisplay};
        UIColor *colors[] = {
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor purpleColor]};
        NSString *categories[] = {@"LOVE IT", @"LIKE IT", @"MEH", @"HATE IT"};
        
        for (int i = 0; i < 4 ; i++){
            double position = i*10; //Bars will be 10 pts away from each other
            double height = bar_heights[i];
            
            NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithDouble:position],BAR_POSITION,
                                 [NSNumber numberWithDouble:height],BAR_HEIGHT,
                                 colors[i],COLOR,
                                 categories[i],CATEGORY,
                                 nil];
            [self.data addObject:bar];
            
        }

    [graph  reloadData];
    }}



-(IBAction)likerate:(id)sender{
    
    
    //pulling rating data from parse 
    
    PFQuery *query = [ PFQuery queryWithClassName:@"graph"];
    PFObject *lovescore = [query getObjectWithId:@"aP1C2cCFhY"];
    int lovedisplay = [[lovescore objectForKey:@"love"] intValue];
    int likedisplay = [[lovescore objectForKey:@"like"] intValue];
    int mehdisplay = [[lovescore objectForKey:@"meh"] intValue];
    int hatedisplay = [[lovescore objectForKey:@"hate"] intValue];
    
   
    
    [lovescore incrementKey:@"like" byAmount:[NSNumber numberWithInt:1]];
    [lovescore saveInBackground];
    
    
    
    
   
    NSString *likestring = [NSString stringWithFormat:@"%i", likedisplay+1];
  
    
    
    
    //setting initail rating values
   
    [likecount setText:likestring];
   
    
    
    if (self) {
        
        self.data = [NSMutableArray array];
        
        int bar_heights[] = {lovedisplay,likedisplay+1,mehdisplay,hatedisplay};
        UIColor *colors[] = {
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor purpleColor]};
        NSString *categories[] = {@"LOVE IT", @"LIKE IT", @"MEH", @"HATE IT"};
        
        for (int i = 0; i < 4 ; i++){
            double position = i*10; //Bars will be 10 pts away from each other
            double height = bar_heights[i];
            
            NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithDouble:position],BAR_POSITION,
                                 [NSNumber numberWithDouble:height],BAR_HEIGHT,
                                 colors[i],COLOR,
                                 categories[i],CATEGORY,
                                 nil];
            [self.data addObject:bar];
            
        }
        
        [graph  reloadData];
    }}

-(IBAction)mehrate:(id)sender{
    
    
    //pulling rating data from parse 
    
    PFQuery *query = [ PFQuery queryWithClassName:@"graph"];
    PFObject *lovescore = [query getObjectWithId:@"aP1C2cCFhY"];
    int lovedisplay = [[lovescore objectForKey:@"love"] intValue];
    int likedisplay = [[lovescore objectForKey:@"like"] intValue];
    int mehdisplay = [[lovescore objectForKey:@"meh"] intValue];
    int hatedisplay = [[lovescore objectForKey:@"hate"] intValue];
    
    
    
    [lovescore incrementKey:@"meh" byAmount:[NSNumber numberWithInt:1]];
    [lovescore saveInBackground];
    
    
    
    
   
    NSString *mehstring = [NSString stringWithFormat:@"%i", mehdisplay+1];
   
    
    
    
    //setting initail rating values
  
    [mehcount setText:mehstring];
    
    
    if (self) {
        
        self.data = [NSMutableArray array];
        
        int bar_heights[] = {lovedisplay,likedisplay,mehdisplay+1,hatedisplay};
        UIColor *colors[] = {
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor purpleColor]};
        NSString *categories[] = {@"LOVE IT", @"LIKE IT", @"MEH", @"HATE IT"};
        
        for (int i = 0; i < 4 ; i++){
            double position = i*10; //Bars will be 10 pts away from each other
            double height = bar_heights[i];
            
            NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithDouble:position],BAR_POSITION,
                                 [NSNumber numberWithDouble:height],BAR_HEIGHT,
                                 colors[i],COLOR,
                                 categories[i],CATEGORY,
                                 nil];
            [self.data addObject:bar];
            
        }
        
        [graph  reloadData];
    }}

-(IBAction)haterate:(id)sender{
    
    
    //pulling rating data from parse 
    
    PFQuery *query = [ PFQuery queryWithClassName:@"graph"];
    PFObject *lovescore = [query getObjectWithId:@"aP1C2cCFhY"];
    int lovedisplay = [[lovescore objectForKey:@"love"] intValue];
    int likedisplay = [[lovescore objectForKey:@"like"] intValue];
    int mehdisplay = [[lovescore objectForKey:@"meh"] intValue];
    int hatedisplay = [[lovescore objectForKey:@"hate"] intValue];
    
    
    
    [lovescore incrementKey:@"hate" byAmount:[NSNumber numberWithInt:1]];
    [lovescore saveInBackground];
    
    
    
    
   
    NSString *hatestring = [NSString stringWithFormat:@"%i", hatedisplay+1];
    
    
    
    //setting initail rating values
    
    [hatecount setText:hatestring];
    
    
    if (self) {
        
        self.data = [NSMutableArray array];
        
        int bar_heights[] = {lovedisplay,likedisplay,mehdisplay,hatedisplay+1};
        UIColor *colors[] = {
            [UIColor redColor],
            [UIColor blueColor],
            [UIColor orangeColor],
            [UIColor purpleColor]};
        NSString *categories[] = {@"LOVE IT", @"LIKE IT", @"MEH", @"HATE IT"};
        
        for (int i = 0; i < 4 ; i++){
            double position = i*10; //Bars will be 10 pts away from each other
            double height = bar_heights[i];
            
            NSDictionary *bar = [NSDictionary dictionaryWithObjectsAndKeys:
                                 [NSNumber numberWithDouble:position],BAR_POSITION,
                                 [NSNumber numberWithDouble:height],BAR_HEIGHT,
                                 colors[i],COLOR,
                                 categories[i],CATEGORY,
                                 nil];
            [self.data addObject:bar];
            
        }
        
        [graph  reloadData];
    }}






- (void)viewDidUnload
{
    //[self setPicture:nil];   **NOT SURE WHAT THIS IS.. it was giving me erros, so I commented it out and it seems to work now
    
    
    
 
    
    
    
    
    
    [self setScrolView:nil];
    
    
    
    [self setLikecount:nil];
    [self setLikecount:nil];
    
    
    
    
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


/* Not being used right now
-(IBAction)graphbutton:(id)sender {
    
    
    BarPlotViewController *barPlotViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"bargraph"];
    [self.navigationController pushViewController:barPlotViewController animated:YES];
    
    
}
*/



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

#pragma mark - Logout method

- (void)logoutButtonTouchHandler:(id)sender 
{
    // Logout user, this automatically clears the cache
    [PFUser logOut];
    
     //Return to login view controller
    [self.navigationController popToRootViewControllerAnimated:YES];    
}



@end
















