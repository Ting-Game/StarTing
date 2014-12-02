//
//  CCNode+ShowMembersScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 12/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ShowMembersScene.h"
#import <Parse/Parse.h>
#import "FriendNode.h"

@implementation ShowMembersScene{
    CCLabelTTF *GroupName_TTF;
}

- (void)onEnter{
    [super onEnter];
    GroupName_TTF.string = self.Display_Group_Name;
    
    [PFCloud callFunctionInBackground:@"getGroup"
                       withParameters:@{@"groupID" : self.Group_Id}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        NSArray *groupmember_array = success[@"members"];
                                        if (groupmember_array.count > 0) {
                                            float y = 0.78;
                                            for (int i = 0; i < groupmember_array.count; i++) {
                                                FriendNode *fn = (FriendNode*)[CCBReader load:@"FriendNode"];
                                                
                                                fn.friend_name = groupmember_array[i];
                                                fn.positionType = CCPositionTypeNormalized;
                                                fn.position = CGPointMake(0.5, y);
                                                [self addChild:fn];
                                                y -= 0.091;
                                            }
                                        }
                                        else {
                                        }
                                    }
                                    else {
                                        
                                    }
                                }];
}

- (void)backToEachGroupScene_button{
    [self removeFromParent];
}

@end
