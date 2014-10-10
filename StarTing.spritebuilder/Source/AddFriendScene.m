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
                                        [self removeFromParent];
                                        CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
                                        [[CCDirector sharedDirector] replaceScene:MainScene];
                                    }else {
                                        NSString *errorString = [error userInfo][@"error"];
                                        nouser_hint.string = errorString;
                                    }
                                }];
}

- (void) Backto_FriendsScene_Button{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}
@end
