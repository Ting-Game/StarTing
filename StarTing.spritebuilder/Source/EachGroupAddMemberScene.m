//
//  CCNode+EachGroupAddMemberScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EachGroupAddMemberScene.h"
#import <Parse/Parse.h>
#import "AddGroupMemberListnode.h"

@implementation EachGroupAddMemberScene{
    CCLabelTTF *Each_Group_Name_TTF;
    CCScrollView *AddGroupMember_scroll;
}

- (void)onEnter{
    [super onEnter];
    Each_Group_Name_TTF.string = self.Display_Group_Name;
    // pull friends list from Parse
    [PFCloud callFunctionInBackground:@"getFriends"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        if (success != NULL) {
                                            if (success.count > 0) {
                                                float y = 35;
                                                for (int i=0; i < success.count; i++)
                                                {
                                                    NSString *friendName = success[i];
                                                    
                                                    AddGroupMemberListnode *listnode =(AddGroupMemberListnode*)[CCBReader load:@"AddGroupMemberListnode"];
                                                    listnode.Group_Id = self.Group_Id;
                                                    listnode.ListNode_Name = friendName;
                                                    //label.fontName = @"Sansation-BoldItalic.ttf";
                                                    listnode.anchorPoint = CGPointMake(0, 0);
                                                    //label.positionType = CCPositionTypeNormalized;
                                                    listnode.position = CGPointMake(0, 50 + i * (listnode.contentSizeInPoints.height));
                                                    listnode.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                    [[AddGroupMember_scroll contentNode] addChild:listnode];
                                                    y+=listnode.contentSizeInPoints.height + 2;
                                                }
                                            }
                                            else {
                                                
                                            }
                                        }
                                    }
                                }];
}

- (void)Backto_GroupsScene_Button{
    [self removeFromParent];
}

- (void)AddFriendsToGroup_Button{
    
}

@end
