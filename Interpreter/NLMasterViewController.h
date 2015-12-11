//
//  NLMasterViewController.h
//  Interpreter
//
//  Created by Sam Rijs on 1/28/14.
//  Copyright (c) 2014 Sam Rijs. All rights reserved.
//

#import "FHSegmentedViewController.h"

@class Nodelike;
//#import "NLContext.h"

@interface NLMasterViewController : FHSegmentedViewController

@property UIViewController *editorViewController, *consoleViewController, *documentationViewController;

@property Nodelike *node;


- (void)executeJS:(NSString *)code;

@end
