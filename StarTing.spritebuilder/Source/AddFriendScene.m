//
//  CCNode+AddFriendScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AddFriendScene.h"
#import <Parse/Parse.h>

@implementation AddFriendScene{
    CCTextField * search_name_Field;
    CCLabelTTF *nouser_hint;
}

- (void) Friend_Search_Button{
    NSString *search_friend_name = search_name_Field.string;
    
    [PFCloud callFunctionInBackground:@"addFriend"
                       withParameters:@{@"friendUsername" : search_friend_name}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        nouser_hint.string = @"Add friend successfully";
//                                        [NSThread sleepForTimeInterval:3.f];
//                                        [self removeFromParent];
//                                        CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
//                                        [[CCDirector sharedDirector] replaceScene:FriendsScene];
                                    }else {
                                        NSString *errorString = [error userInfo][@"error"];
                                        nouser_hint.string = errorString;
                                    }
                                }];
}

- (void) Backto_FriendsScene_Button{
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [[CCDirector sharedDirector] replaceScene:FriendsScene];
}
@end
