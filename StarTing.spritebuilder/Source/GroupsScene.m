//
//  CCNode+GroupsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GroupsScene.h"
#import <Parse/Parse.h>

@implementation GroupsScene{
    CCLabelTTF *nogroups_hint;
    CCScrollView *groups_scroll;
    NSMutableArray *grouplist;
}

- (void)didLoadFromCCB {
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
                                                    
                                                    CCLabelTTF *label = [CCLabelTTF node];
                                                    //label.fontName = @"Sansation-BoldItalic.ttf";
                                                    label.fontSize = 15.f;
                                                    label.string = [NSString stringWithFormat:@"%@",each_object_groupname];
                                                    label.anchorPoint = CGPointMake(0, 0);
                                                    //label.positionType = CCPositionTypeNormalized;
                                                    label.position = CGPointMake(100, 35 + i * (label.contentSizeInPoints.height + 2));
                                                    label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                    label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                    [[groups_scroll contentNode] addChild:label];

                                                }
                                            }
                                            else {
                                                nogroups_hint.string = @"Please create group";
                                            }
                                        }
                                    }
                                }];
}

- (void)CreateGroups_Button {
    CCScene *CreateGroupScene = [CCBReader loadAsScene:@"CreateGroupScene"];
    [self addChild:CreateGroupScene];
}

- (void)Backto_GroupsScene_Button{
    CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector] replaceScene:MainScene];
}

@end
