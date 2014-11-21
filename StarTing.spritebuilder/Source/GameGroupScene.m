//
//  CCNode+GameGroupScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/16/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GameGroupScene.h"
#import <Parse/Parse.h>
#import "GroupNodeForGame.h"

@implementation GameGroupScene

- (void)onEnter{
    [super onEnter];
    // pull groups list from Parse
    [PFCloud callFunctionInBackground:@"getGroups"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        if (success != NULL) {
                                            if (success.count > 0) {
                                                for (int i = 0; i < success.count; i++) {
                                                    PFObject *each_object = success[i];
                                                    NSString *each_object_groupname = each_object[@"name"];
                                                    NSString *each_object_groupid = each_object.objectId;
                                                    
                                                    GroupNodeForGame *groupNodeForGame = (GroupNodeForGame*)[CCBReader load:@"GroupNodeForGame"];
                                                    groupNodeForGame.ListNode_Name = each_object_groupname;
                                                    groupNodeForGame.ListNode_Groupid= each_object_groupid;

                                                    groupNodeForGame.anchorPoint = CGPointMake(0, 0);
                                                    groupNodeForGame.position = CGPointMake(0, 220 + i * (groupNodeForGame.contentSizeInPoints.height));
                                                    groupNodeForGame.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                    [self addChild:groupNodeForGame];
                                                    
                                                }
                                            }
                                            else {
                                            }
                                        }
                                    }
                                }];

}

- (void)backToGroupSelectScene_button{
    CCScene *SelectGameScene = [CCBReader loadAsScene:@"SelectGameScene"];
    [[CCDirector sharedDirector] replaceScene:SelectGameScene];
}

@end
