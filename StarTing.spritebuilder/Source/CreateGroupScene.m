//
//  CCNode+CreateGroupScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "CreateGroupScene.h"
#import <Parse/Parse.h>

@implementation CreateGroupScene{
    CCTextField *group_name_Field;
}

- (void)Create_Group_Button {
    NSString *create_group_name = group_name_Field.string;
    
    [PFCloud callFunctionInBackground:@"createGroup"
                       withParameters:@{@"groupName" : create_group_name}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        [self removeFromParent];
                                        CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
                                        [[CCDirector sharedDirector] replaceScene:MainScene];
                                    }
                                }];

}

- (void)Backto_GroupsScene_Button{
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

@end
