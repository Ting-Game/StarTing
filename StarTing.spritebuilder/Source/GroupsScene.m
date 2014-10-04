//
//  CCNode+GroupsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GroupsScene.h"

@implementation GroupsScene

- (void)CreateGroups_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [self addChild:FriendsScene];
}

@end
