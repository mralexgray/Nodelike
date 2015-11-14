//
//  AppDelegate.m
//  nodish
//
//  Created by Alex Gray on 11/14/15.
//  Copyright © 2015 Sam Rijs. All rights reserved.
//

#import "AppDelegate.h"

@interface NLRunner :NSObject
@property NLContext *context;
@end

@implementation NLRunner


- init {

  self = super.init;
  _context = [NLContext.alloc initWithVirtualMachine:JSVirtualMachine.new];

  [NLContext attachToContext:_context];
    
    _context.exceptionHandler = ^(JSContext *c, JSValue *e) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@ stack: %@", [e toString], [e valueForProperty:@"stack"]);
        });
    };
    
    id logger = ^(JSValue *thing) {
        [JSContext.currentArguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSLog(@"log: %@", [obj toString]);
        }];
    };
    _context[@"console"] = @{@"log": logger, @"error": logger};
    
    //[_context evaluateScript:@"process.env['NODE_DEBUG']='module'"];
  return self;
}


- (void)executeJS:(NSString *)code {

    JSValue *ret = [_context evaluateScript:code];
    if (![ret isUndefined]) {
        NSLog(@"%@", [ret toString]);
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NLContext runEventLoopSync];

    });

}
@end

@interface AppDelegate ()

@property NLRunner *runner;
@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void) applicationDidFinishLaunching:(NSNotification *)notification {

//  NSLog(@"%@",[NLNatives modules]);
  _runner = NLRunner.new;
  [_runner executeJS:@"var a = \"apple\"; console.log(Object.keys(process));"];

//  NSLog(@"%@", );

}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
