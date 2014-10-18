//
//  CCNode+GamesScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/4/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "GamesScene.h"

@implementation GamesScene

- (void)Friends_Button {
    CCScene *FriendsScene = [CCBReader loadAsScene:@"FriendsScene"];
    [[CCDirector sharedDirector] replaceScene:FriendsScene];
}

- (void)Groups_Button {
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)Games_Button {
    CCScene *GamesScene = [CCBReader loadAsScene:@"GamesScene"];
    [[CCDirector sharedDirector] replaceScene:GamesScene];
}

- (void)Settings_Button {
    CCScene *SettingsScene = [CCBReader loadAsScene:@"SettingsScene"];
    [[CCDirector sharedDirector] replaceScene:SettingsScene];
}

@end