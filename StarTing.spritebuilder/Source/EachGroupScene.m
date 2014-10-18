//
//  CCNode+EachGroupScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EachGroupScene.h"
#import <Parse/Parse.h>

@implementation EachGroupScene{
    CCLabelTTF *Each_Group_Name_TTF;
}

- (void)onEnter {
    [super onEnter];
    Each_Group_Name_TTF.string = self.Display_Group_Name;
}

- (void)Backto_GroupsScene_Button{
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)AddGroupMember_Button{
    [PFCloud callFunctionInBackground:@"addGroupMember"
                       withParameters:@{@"memberUsername" : @"zhanpeng", @"groupID" : self.Group_Id}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success);
                                        NSLog(@"Successfully add group member!");
                                    }else {
                                        NSString *errorString = [error userInfo][@"error"];
                                        NSLog(@"%@", errorString);
                                    }
                                }];
}

@end
