//
//  AppDelegate.m
//  nodish
//
//  Created by Alex Gray on 11/14/15.
//  Copyright © 2015 Sam Rijs. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property NLContext* ctx;

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)awakeFromNib {

  NLContext *ctx = [NLContext.alloc initWithVirtualMachine:JSVirtualMachine.new];

  NSLog(@"%@", _ctx);
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
  // Insert code here to tear down your application
}

@end
