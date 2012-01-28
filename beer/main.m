//
//  main.m
//  beer
//
//  Created by Chris Griffith on 1/21/12.
//  Copyright (c) 2012 Levi Strauss & Co. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

#import "beerAppDelegate.h"

int main(int argc, char *argv[])
{
    
// This is the key info for parse.com
    [Parse setApplicationId:@"vzgdhTdNRBcaT5WDsQM7rz2OyAHAGbwLfdxz4lap" 
                  clientKey:@"bozaqLkwN8dSsSMRRLtM9WyN1ouHlVzaCzhCQjki"];
// This is the key info for parse.com    
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([beerAppDelegate class]));
    }
}
