//
//  CCNode+RegisterScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/9/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "RegisterScene.h"
#import <Parse/Parse.h>

@implementation RegisterScene{
    CCTextField *UserName_Field;
    CCTextField *Password_Field;
    CCTextField *Phone_Field;
    CCTextField *Email_Field;
    CCLabelTTF *Error_TTF;
}

- (void)SignUp_Button {
    NSString *UserName = UserName_Field.string;
    NSString *Password = Password_Field.string;
    NSString *PhoneNumber = Phone_Field.string;
    NSString *Email = Email_Field.string;

    // Send user name and password to Parse
    PFUser *user = [PFUser user];
    user.username = UserName;
    user.password = Password;
    user.email = Email;
    
    // other fields can be set if you want to save more information
    user[@"phone"] = PhoneNumber;
    
    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            // log in immediately
            [PFUser logInWithUsernameInBackground:UserName password:Password
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    // Do stuff after successful login.
                                                } else {
                                                    // The login failed. Check error to see why.
                                                }
                                            }];
            CCScene *MainScene = [CCBReader loadAsScene:@"MainScene"];
            [[CCDirector sharedDirector] replaceScene:MainScene];
        } else {
            // Show the errorString and let the user try again.
            NSString *errorString = [error userInfo][@"error"];
            Error_TTF.string = errorString;
        }
    }];
}

@end
