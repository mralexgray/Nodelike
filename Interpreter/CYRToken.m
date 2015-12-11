//
//  CYRTextAttribute.m
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
#import "CYRToken.h"

@implementation CYRToken

+ (instancetype)tokenWithName:(NSString *)name expression:(NSString *)expression attributes:(NSDictionary *)attributes
{
    CYRToken *textAttribute = [CYRToken new];
    
    textAttribute.name = name;
    textAttribute.expression = expression;
    textAttribute.attributes = attributes;
    
    return textAttribute;
}

@end
