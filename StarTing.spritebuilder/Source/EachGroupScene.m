//
//  CCNode+EachGroupScene.m
//  StarTing
//
//  Created by Yuefeng Wu on 10/17/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "EachGroupScene.h"
#import <Parse/Parse.h>
#import "EachGroupAddMemberScene.h"

@implementation EachGroupScene{
    CCLabelTTF *Each_Group_Name_TTF;
    CCLabelTTF *nogroupmember_hint;
    CCTextField *sendmessage_Field;
    CCScrollView *messages_scroll;
    int currentMessages;
}

- (void)onEnter {
    [super onEnter];
    Each_Group_Name_TTF.string = self.Display_Group_Name;
    [self retrieveMessages];
    [self schedule:@selector(retrieveMessages) interval:5.0f];
    currentMessages = 0;
//    [PFCloud callFunctionInBackground:@"getGroup"
//                       withParameters:@{@"groupID" : self.Group_Id}
//                                block:^(PFObject *success, NSError *error) {
//                                    if (!error) {
//                                        nogroupmember_hint.string = @"";
//                                        NSArray *groupmember_array = success[@"members"];
//                                        if (groupmember_array.count > 0) {
//                                            for (int i = 0; i < groupmember_array.count; i++) {
//                                                CCLabelTTF *label = [CCLabelTTF node];
//                                                //label.fontName = @"Sansation-BoldItalic.ttf";
//                                                label.fontSize = 15.f;
//                                                label.string = [NSString stringWithFormat:@"%@",groupmember_array[i]];
//                                                label.anchorPoint = CGPointMake(0, 0);
//                                                //label.positionType = CCPositionTypeNormalized;
//                                                label.position = CGPointMake(120, 100 + i * 25);
//                                                label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
//                                                label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
//                                                [self addChild:label];
//                                            }
//                                        }
//                                        else {
//                                            nogroupmember_hint.string = @"Please add group member";
//                                        }
//                                    }
//                                    else {
//
//                                    }
//                                }];
}

- (void)Backto_GroupsScene_Button{
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)AddGroupMember_Button{
    EachGroupAddMemberScene *eachGroupAddMemberScene = (EachGroupAddMemberScene*)[CCBReader load:@"EachGroupAddMemberScene"];
    eachGroupAddMemberScene.Group_Id = self.Group_Id;
    eachGroupAddMemberScene.Display_Group_Name = self.Display_Group_Name;
    [self addChild:eachGroupAddMemberScene];
}

- (void)quitgroup_Button{
    [PFCloud callFunctionInBackground:@"changeLeader"
                       withParameters:@{@"groupID" : self.Group_Id, @"newLeader" : @"zhanpeng"}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        
                                    }
                                    else {
                                        
                                    }
                                }];
    
    [PFCloud callFunctionInBackground:@"quitGroup"
                       withParameters:@{@"groupID" : self.Group_Id}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        
                                    }
                                    else {
                                        
                                    }
                                }];
    CCScene *GroupsScene = [CCBReader loadAsScene:@"GroupsScene"];
    [[CCDirector sharedDirector] replaceScene:GroupsScene];
}

- (void)retrieveMessages{
    PFUser *currentUser = [PFUser currentUser];
    //[[messages_scroll contentNode] removeAllChildren];
    messages_scroll.verticalScrollEnabled = YES;
    messages_scroll.horizontalScrollEnabled = YES;
    
    [PFCloud callFunctionInBackground:@"getChatInfo"
                       withParameters:@{@"groupID" : self.Group_Id}
                                block:^(NSArray *success, NSError *error) {
                                    if (!error) {
                                        for (int i = currentMessages; i < success.count; i++) {
                                            if ([success[i][@"user"] isEqualToString: currentUser[@"username"]]) {
                                                CCLabelTTF *label = [CCLabelTTF node];
                                                label.fontSize = 15.f;
                                                label.string = [NSString stringWithFormat:@"%@",success[i][@"chatInfo"]];
                                                label.anchorPoint = CGPointMake(0, 0);
                                                //label.positionType = CCPositionTypeNormalized;
                                                label.position = CGPointMake(220, currentMessages * 25);
                                                label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                [[messages_scroll contentNode] addChild:label];
                                            } else {
                                                CCLabelTTF *label = [CCLabelTTF node];
                                                label.fontSize = 15.f;
                                                label.string = [NSString stringWithFormat:@"%@",success[i][@"chatInfo"]];
                                                label.anchorPoint = CGPointMake(0, 0);
                                                //label.positionType = CCPositionTypeNormalized;
                                                label.position = CGPointMake(40, currentMessages * 25);
                                                label.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
                                                label.positionType = CCPositionTypeMake(CCPositionTypePoints.xUnit, CCPositionTypePoints.yUnit, CCPositionReferenceCornerTopLeft);
                                                [[messages_scroll contentNode] addChild:label];
                                            }
                                            currentMessages++;
                                        }
                                    }
                                    else {
                                        
                                    }
                                }];
}

- (void)sendmessage_Button{
    NSString *sendMessage = sendmessage_Field.string;
    [PFCloud callFunctionInBackground:@"postChatInfo"
                       withParameters:@{@"groupID" : self.Group_Id, @"chatInfo" : sendMessage}
                                block:^(NSString *success, NSError *error) {
                                    if (!error) {
                                        NSLog(@"%@", success);
                                    }
                                    else {
                                        
                                    }
                                }];
    sendmessage_Field.string = @"";
    [NSThread sleepForTimeInterval:0.1f];
    [self retrieveMessages];
}

@end
