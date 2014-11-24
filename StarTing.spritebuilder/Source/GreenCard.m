//
//  CCSprite+GreenCard.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GreenCard.h"

@implementation GreenCard{
    CCLabelTTF *Keyword_TTF;
    CCLabelTTF *Detail_TTF;
}

- (void)onEnter{
    [super onEnter];
    Keyword_TTF.string = self.keyword;
    Detail_TTF.string = self.detail;
}

@end
