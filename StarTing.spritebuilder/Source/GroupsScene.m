//
//  CCNode+GroupsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GroupsScene.h"
#import <Parse/Parse.h>

@implementation GroupsScene

- (void)didLoadFromCCB {
    //
    NSArray *friends_list;
    [PFCloud callFunctionInBackground:@"getGroups"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success[0]);
                                        // Push sent successfully
                                    }
                                }];
}

- (void)CreateGroups_Button {
    [PFCloud callFunctionInBackground:@"createGroup"
                       withParameters:@{}
                                block:^(NSString *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success);
                                        // Push sent successfully
                                    }
                                }];}

@end
