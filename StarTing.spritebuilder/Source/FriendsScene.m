//
//  CCNode+FriendsScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/3/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "FriendsScene.h"
#import <Parse/Parse.h>

@implementation FriendsScene

- (void)didLoadFromCCB {
    //
    NSArray *friends_list;
    [PFCloud callFunctionInBackground:@"getFriends"
                       withParameters:@{}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success[2]);
                                        // Push sent successfully
                                    }
                                }];
}

- (void)AddFriends_Button {
    
//    PFUser *user = [PFUser user];
//    user.username = @"Fred";
//    user.password = @"123";
//    user.email = @"email@example.com";
//    
//    // other fields can be set if you want to save more information
//    user[@"phone"] = @"650-555-0000";
//    
//    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//        if (!error) {
//            // Hooray! Let them use the app now.
//        } else {
//            NSString *errorString = [error userInfo][@"error"];
//            // Show the errorString somewhere and let the user try again.
//        }
//    }];
//    
//    PFObject *testObject = [PFObject objectWithClassName:@"TestObject"];
//    testObject[@"foo"] = @"bar";
//    [testObject saveInBackground];
    [PFCloud callFunctionInBackground:@"addFriend"
                       withParameters:@{@"friendUsername": @"raulpitz"}
                                block:^(NSString *success, NSError *error) {
                                    if (!error) {
                                        //NSLog(@"%@", success);
                                        // Push sent successfully
                                    }
                                }];

}

@end