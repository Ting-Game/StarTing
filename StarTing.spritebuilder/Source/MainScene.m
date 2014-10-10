//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import <Parse/Parse.h>

@implementation MainScene{
    CCScene *currentScene;
}

- (void)didLoadFromCCB {
    currentScene = [CCBReader loadAsScene:@"FriendsScene"];
    [self addChild:currentScene];
}

- (void)Friends_Button {
    [self removeChild:currentScene];
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [self addChild:FriendsScene];
    currentScene = FriendsScene;
}

- (void)Groups_Button {
    [self removeChild:currentScene];
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [self addChild:GroupsScene];
    currentScene = GroupsScene;
}

- (void)Games_Button {
    [self removeChild:currentScene];
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [self addChild:GamesScene];
    currentScene = GamesScene;
}

- (void)Settings_Button {
    [self removeChild:currentScene];
    CCScene *SettingsScene = [CCBReader loadAsScene:@"SettingsScene"];
    [self addChild:SettingsScene];
    currentScene = SettingsScene;
}

@end