//
//  CCNode+FriendNode.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FriendNode.h"

@implementation FriendNode{
    CCTextField *friend_name_TTF;
}

- (void)onEnter{
    [super onEnter];
    friend_name_TTF.string = self.friend_name;
}

@end
