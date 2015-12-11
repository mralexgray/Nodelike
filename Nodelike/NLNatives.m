//
//  NLNatives.m
//  Nodelike
//
//  Created by Sam Rijs on 1/25/14.
//  Copyright (c) 2014 Sam Rijs.
//
//  This Source Code Form is subject to the terms of the Mozilla Public
//  License, v. 2.0. If a copy of the MPL was not distributed with this
//  file, You can obtain one at http://mozilla.org/MPL/2.0/.

#import "NLNatives.h"

static NSMutableArray *otherModules;

@implementation NLNatives

+ (void) initialize { otherModules = @[].mutableCopy; }


+ (NSBundle *)bundle {

    NSBundle *bundle     = [NSBundle bundleForClass:self.class];
    NSString *bundlePath = [bundle pathForResource:@"Nodelike" ofType:@"bundle"];

    return bundlePath ? [NSBundle bundleWithPath:bundlePath] : bundle;
}

+ (NSArray *)modules {

    NSMutableArray *files = [self.bundle pathsForResourcesOfType:@"js" inDirectory:nil].mutableCopy;
    [files addObjectsFromArray:otherModules];
//    [NSBundle pathsForResourcesOfType:@"js" inDirectory:self.bundle.bundlePath];
    NSMutableArray *modules = @[].mutableCopy;
    for (id thing in files) {
      NSURL * url = ![thing isKindOfClass:NSString.class] ? thing : [NSURL fileURLWithPath:thing];
      NSString *name = [[url lastPathComponent] substringToIndex:[url lastPathComponent].length - [url pathExtension].length - 1];
        [modules addObject:name];
    }
//    NSLog(@"modules %@", modules);
    return modules;
}

+ (NSString *)source:(NSString *)module {

    NSString *path    =// [self.bundle.bundlePath stringByAppendingFormat:@"/lib/%@.js", module];
     [self.bundle pathForResource:module ofType:@"js" inDirectory:nil];
    NSString *content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:nil];
    return content;
}

+ (void) loadModule:(NSString*) path {

  id pathToLoad = [path.pathExtension isEqualToString:@"js"] ? path : ({

    id json = [path stringByAppendingPathComponent:@"package.json"];
    [NSFileManager.defaultManager fileExistsAtPath:json] ? ({

      NSLog(@"parsing json: %@", json);
      NSError * e= nil;
      NSString *jsonString = [NSString stringWithContentsOfFile:json encoding:NSUTF8StringEncoding error:&e];
      NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];

      id parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&e];

//      NSLog(@"parsed: %@", parsedData);
//      id d = [[NSString.alloc initWithContentsOfFile:json encoding:NSUTF8StringEncoding]



      id main = parsedData[@"main"] ?: [path stringByAppendingPathComponent:@"index.js"];
      NSLog(@"found main: %@", main);
      main;

    }) : [path stringByAppendingPathComponent:@"index.js"];
  });

  JSValue *sources = [JSValue valueWithNewObjectInContext:JSContext.currentContext];
  [sources defineProperty:[pathToLoad stringByDeletingLastPathComponent]
                     descriptor:@{ JSPropertyDescriptorGetKey: ^{

      return [NSString.alloc initWithContentsOfFile:pathToLoad encoding:NSUTF8StringEncoding error:nil];
    }}
  ];

}

+ binding {
    NSArray *modules = [self modules];
    JSValue *sources = [JSValue valueWithNewObjectInContext:JSContext.currentContext];
    for (int i = 0; i < modules.count; i++) {
        NSString *name = modules[i];
        [sources defineProperty:name
                     descriptor:@{JSPropertyDescriptorGetKey: ^{ return [NLNatives source:name]; }}];
    }
    return sources;
}

@end
