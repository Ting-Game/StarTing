//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import <Parse/Parse.h>

@implementation MainScene

- (void)didLoadFromCCB {
    [self Friends_Button];
    [PFUser logInWithUsernameInBackground:@"Fred" password:@"123"
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            NSLog(@"Log in successfully!");
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
    PFUser *currentUser = [PFUser currentUser];
    if (currentUser) {
        // do stuff with the user
    } else {
        // show the signup or login screen
    }
}

- (void)Friends_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [self addChild:FriendsScene];
}

- (void)Groups_Button {
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [self addChild:GroupsScene];
}

- (void)Games_Button {
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [self addChild:GamesScene];
}

- (void)Settings_Button {
    CCScene *SettingsScene = [CCBReader loadAsScene:@"SettingsScene"];
    [self addChild:SettingsScene];
}

@end