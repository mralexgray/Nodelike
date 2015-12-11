//
//  CYRLayoutManager.h
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
//  Original implementation taken from: https://github.com/alldritt/TextKit_LineNumbers
//
// The MIT License (MIT)
//
// Copyright (c) 2014 Cyrillian, Inc.
//
#import <UIKit/UIKit.h>

@interface CYRLayoutManager : NSLayoutManager

@property (nonatomic) UIFont *lineNumberFont;
@property (nonatomic) UIColor *lineNumberColor;

@property (readonly) CGFloat gutterWidth;
@property (nonatomic) NSRange selectedRange;

- (CGRect)paragraphRectForRange:(NSRange)range;

@end
