//
//  BarPlotViewController.h
//  beer
//
//  Created by Chris Griffith on 2/18/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"



@interface BarPlotViewController : UIViewController 
<CPTBarPlotDataSource, CPTBarPlotDelegate>

@property (nonatomic, retain) NSMutableArray *data;
@property (nonatomic, retain) CPTGraphHostingView *hostingView;
@property (nonatomic, retain) CPTXYGraph *graph;

- (void)generateBarPlot;




@end
