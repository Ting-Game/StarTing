//
//  CCNode+SelectGameScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "SelectGameScene.h"
#import "GameNode.h"

@implementation SelectGameScene

- (void)onEnter{
    [super onEnter];
    
    GameNode *gameNode = (GameNode*)[CCBReader load:@"GameNode"];
    gameNode.anchorPoint = CGPointMake(0, 0);
    gameNode.position = CGPointMake(0, 250 + gameNode.contentSizeInPoints.height);
    gameNode.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
    [self addChild:gameNode];
}

- (void)backToGameScene_button {
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

@end
