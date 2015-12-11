//
//  CYRTextAttribute.h
//
//  Version 0.2.0
//
//  Created by Illya Busigin on 01/05/2014.
//  Copyright (c) 2014 Cyrillian, Inc.
//
//  Distributed under MIT license.
//  Get the latest version from here:
//
//  https://github.com/illyabusigin/CYRTextView
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Cyrillian, Inc.
//
#import <Foundation/Foundation.h>

@interface CYRToken : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *expression;
@property (nonatomic, strong) NSDictionary *attributes;

+ (instancetype)tokenWithName:(NSString *)name expression:(NSString *)expression attributes:(NSDictionary *)attributes;

@end
