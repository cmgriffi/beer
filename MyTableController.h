//
//  MyTableController.h
//  beer
//
//  Created by Chris Griffith on 3/11/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <Parse/Parse.h>

@interface MyTableController : PFQueryTableViewController {
    NSArray *cellIconNames;
}

@property (nonatomic, retain) NSArray *cellIconNames;

@end
