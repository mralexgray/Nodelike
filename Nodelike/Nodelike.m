//
//  Nodelike.m
//  Nodelike
//
//  Created by Alex Gray on 12/11/15.
//  Copyright © 2015 Sam Rijs. All rights reserved.
//

#import "Nodelike.h"

@implementation Nodelike

- init {

  self = super.init;

  __weak id weakSelf = self;

  [NLContext attachToContext:_context = [NLContext.alloc initWithVirtualMachine:JSVirtualMachine.new]];

  _context.exceptionHandler = ^(JSContext *c, JSValue *e) {

    dispatch_async(dispatch_get_main_queue(), ^{
      //      [weakSelf error:[e toString]];
      NSLog(@"%@ stack: %@", e, [e valueForProperty:@"stack"]);
    });
  };

  id logger = ^(JSValue *thing) {

    for (id obj in JSContext.currentArguments) {

      NSLog(@"log: %@", [obj toString]);
//      [((NLConsoleViewController *)self.consoleViewController) log:[obj toString]];
    }
  };
  _context[@"console"] = @{@"log": logger, @"error": logger};

//  [_context evaluateScript:@"process.env['NODE_DEBUG']='module'"];

  return self;
}


- (NSString*) executeJS:(NSString *)code {


  JSValue *ret = [_context evaluateScript:code];

  if (![ret isUndefined]) return [ret toString];

#if TARGET_OS_IPHONE

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{


    self.backgroundTask = [UIApplication.sharedApplication beginBackgroundTaskWithExpirationHandler:^{
      NSLog(@"beginBG called");
//      [UIApplication.sharedApplication endBackgroundTask:self.backgroundTask];
      self.backgroundTask = UIBackgroundTaskInvalid;
    }];


    [NLContext runEventLoopSync];

    [UIApplication.sharedApplication endBackgroundTask:self.backgroundTask];
    self.backgroundTask = UIBackgroundTaskInvalid;

  });

#endif
  return nil;
}

@end

