//
//  SwipeButton.h
//  KeyboardTest
//
//  Created by Kuba on 28.06.12.
//  Copyright (c) 2012 Adam Horacek, Kuba Brecka
//
//  Website: http://www.becomekodiak.com/
//  github: http://github.com/adamhoracek/KOKeyboard
//	Twitter: http://twitter.com/becomekodiak
//  Mail: adam@becomekodiak.com, kuba@becomekodiak.com

#import <UIKit/UIKit.h>

@interface KOSwipeButton : UIView

@property (nonatomic, weak) id delegate;

- (void)setKeys:(NSString *)newKeys;

@end
