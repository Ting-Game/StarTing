//
//  CCNode+GameNode.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameNode.h"

@implementation GameNode

- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = YES;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    CCScene *GameGroupScene = [CCBReader loadAsScene:@"GameGroupScene"];
    [[CCDirector sharedDirector] replaceScene:GameGroupScene];
}

@end
