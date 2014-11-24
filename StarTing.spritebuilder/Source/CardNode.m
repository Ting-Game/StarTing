//
//  CCNode+CardNode.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CardNode.h"

@implementation CardNode{
    CCLabelTTF *cardText_TTF;
}

- (void)onEnter{
    [super onEnter];
    cardText_TTF.string = self.cardKeyword;
}

@end
