//
//  CCNode+AddGroupMemberListnode.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/24/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "AddGroupMemberListnode.h"
#import <Parse/Parse.h>

@implementation AddGroupMemberListnode{
    CCLabelTTF *Display_Name_Inlist_TTF;
    NSString *name;
    NSString *groupid;
}

- (void)onEnter{
    [super onEnter];
    self.userInteractionEnabled = YES;
    Display_Name_Inlist_TTF.string = self.ListNode_Name;
    name = self.ListNode_Name;
    groupid = self.Group_Id;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [PFCloud callFunctionInBackground:@"addGroupMember"
                       withParameters:@{@"memberUsername" : name, @"groupID" : groupid}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success);
                                        NSLog(@"Successfully add group member!");
                                    }else {
                                        NSString *errorString = [error userInfo][@"error"];
                                        NSLog(@"%@", errorString);
                                    }
                                    [self.parent.parent.parent removeFromParent];
                                }];
}

@end
