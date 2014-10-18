//
//  CCNode+listnode.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EachGroupListnode.h"
#import "EachGroupScene.h"

@implementation EachGroupListnode{
    CCLabelTTF *Display_Name_Inlist_TTF;
}

- (void)onEnter {
    [super onEnter];
    self.userInteractionEnabled = YES;
    Display_Name_Inlist_TTF.string = self.ListNode_Name;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    EachGroupScene *eachGroupScene = (EachGroupScene*)[CCBReader load:@"EachGroupScene"];
    eachGroupScene.Display_Group_Name = self.ListNode_Name;
    eachGroupScene.Group_Id = self.ListNode_Groupid;
    [self.parent.parent.parent addChild:eachGroupScene];
    //[[CCDirector sharedDirector] replaceScene:eachGroupScene];
}

@end
