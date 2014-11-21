//
//  CCNode+FriendsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FriendsScene.h"
#import <Parse/Parse.h>

@implementation FriendsScene{
    CCTextField *PopAddFriend_Field;
    CCScrollView *friends_scroll;
    CCLabelTTF *nofriend_hint;
}

- (void)didLoadFromCCB {
    // pull friends list from Parse
    [PFCloud callFunctionInBackground:@"getFriends"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        if (success != NULL) {
                                            if (success.count > 0) {
                                                nofriend_hint.string = @"";
                                                float y = 35;
                                                for (int i=0; i < success.count; i++)
                                                {
                                                    NSString *friendName = success[i];
                                                    
                                                    CCLabelTTF *label = [CCLabelTTF node];
                                                    //label.fontName = @"Sansation-BoldItalic.ttf";
                                                    label.fontSize = 15.f;
                                                    label.string = [NSString stringWithFormat:@"%@",friendName];
                                                    label.anchorPoint = CGPointMake(0, 0);
                                                    //label.positionType = CCPositionTypeNormalized;
                                                    label.position = CGPointMake(120, y);
                                                    label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                    label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                    [[friends_scroll contentNode] addChild:label];
                                                    y+=label.contentSizeInPoints.height + 2;
                                                }
                                            }
                                            else {
                                                nofriend_hint.string = @"Please add friends";
                                            }
                                        }
                                    }
                                }];
}

- (void)Friends_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [[CCDirector sharedDirector] replaceScene:FriendsScene];
}

- (void)Groups_Button {
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)Games_Button {
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

- (void)Settings_Button {
    CCScene *SettingsScene = [CCBReader loadAsScene:@"SettingsScene"];
    [[CCDirector sharedDirector] replaceScene:SettingsScene];
}

- (void)AddFriends_Button {
    CCScene *AddFriendScene = [CCBReader loadAsScene:@"AddFriendScene"];
    [[CCDirector sharedDirector] replaceScene:AddFriendScene];
}

//- (void)DeleteFriends_Button {
//    [PFCloud callFunctionInBackground:@"deleteFriend"
//                       withParameters:@{@"friendUsername" : self.Group_Id}
//                                block:^(PFObject *success, NSError *error) {
//                                    if (!error) {
//                                        
//                                    }
//                                    else {
//                                        
//                                    }
//                                }];
//}

@end