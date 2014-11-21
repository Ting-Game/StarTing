//
//  CCNode+LoginScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "LoginScene.h"
#import <Parse/Parse.h>

@implementation LoginScene{
    CCTextField *UserName_Field;
    CCTextField *Password_Field;
    CCLabelTTF *Error_TTF;
}

- (void)LogIn_Button {
    NSString *UserName = UserName_Field.string;
    NSString *Password = Password_Field.string;
    
    // Send user name and password to Parse
    PFUser *user = [PFUser user];
    user.username = UserName;
    user.password = Password;
    
    [PFUser logInWithUsernameInBackground:UserName password:Password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
                                            [[CCDirector sharedDirector] replaceScene:FriendsScene];
                                        } else {
                                            // The login failed. Check error to see why.
                                            NSString *errorString = [error userInfo][@"error"];
                                            Error_TTF.string = errorString;
                                        }
                                    }];
}

- (void)SignUp_Button {
    CCScene *RegisterScene = [CCBReader loadAsScene:@"RegisterScene"];
    [[CCDirector sharedDirector] replaceScene:RegisterScene];
}

@end
