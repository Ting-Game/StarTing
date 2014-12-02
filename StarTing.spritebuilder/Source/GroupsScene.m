//
//  CCNode+GroupsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GroupsScene.h"
#import "EachGroupListnode.h"
#import <Parse/Parse.h>

@implementation GroupsScene{
    CCLabelTTF *nogroups_hint;
    CCScrollView *groups_scroll;
    CCNode *hand;
    NSMutableArray *grouplist;
}

- (void)didLoadFromCCB {
    hand.visible = NO;
    // pull friends list from Parse
    [PFCloud callFunctionInBackground:@"getGroups"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        if (success != NULL) {
                                            if (success.count > 0) {
                                                nogroups_hint.string = @"";
                                                for (int i = 0; i < success.count; i++) {
                                                    PFObject *each_object = success[i];
                                                    NSString *each_object_groupname = each_object[@"name"];
                                                    NSString *each_object_groupid = each_object.objectId;
                                                    
//                                                    CCLabelTTF *label = [CCLabelTTF node];
//                                                    //label.fontName = @"Sansation-BoldItalic.ttf";
//                                                    label.fontSize = 15.f;
//                                                    label.string = [NSString stringWithFormat:@"%@",each_object_groupname];
//                                                    label.anchorPoint = CGPointMake(0, 0);
//                                                    //label.positionType = CCPositionTypeNormalized;
//                                                    label.position = CGPointMake(100, 35 + i * (label.contentSizeInPoints.height + 2));
//                                                    label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
//                                                    label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
//                                                    [[groups_scroll contentNode] addChild:label];
                                                    
                                                    EachGroupListnode *eachGroupListnode = (EachGroupListnode*)[CCBReader load:@"EachGroupListnode"];
                                                    eachGroupListnode.ListNode_Name = each_object_groupname;
                                                    eachGroupListnode.ListNode_Groupid= each_object_groupid;
                                                    //label.fontName = @"Sansation-BoldItalic.ttf";
                                                    eachGroupListnode.anchorPoint = CGPointMake(0, 0);
                                                    eachGroupListnode.position = CGPointMake(0, 50 + i * (eachGroupListnode.contentSizeInPoints.height));
                                                    eachGroupListnode.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                    [[groups_scroll contentNode] addChild:eachGroupListnode];


                                                }
                                            }
                                            else {
                                                hand.visible = YES;
                                                nogroups_hint.string = @"Please create group here";
                                            }
                                        }
                                    }
                                }];
}

- (void)CreateGroups_Button {
    CCScene *CreateGroupScene = [CCBReader loadAsScene:@"CreateGroupScene"];
    [[CCDirector sharedDirector] replaceScene:CreateGroupScene];
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

@end
