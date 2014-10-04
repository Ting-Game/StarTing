//
//  CCNode+FriendsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FriendsScene.h"

@implementation FriendsScene

- (void)didLoadFromCCB {
    //[self Friends_Button];
}

- (void)AddFriends_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [self addChild:FriendsScene];
}

@end