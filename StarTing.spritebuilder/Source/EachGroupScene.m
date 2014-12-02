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
#import "ShowMembersScene.h"
#import "MyselfMessage.h"
#import "OtherMessage.h"

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

- (void)showMembers_button{
    ShowMembersScene *showMembersScene = (ShowMembersScene*)[CCBReader load:@"ShowMembersScene"];
    showMembersScene.Group_Id = self.Group_Id;
    showMembersScene.Display_Group_Name = self.Display_Group_Name;
    [self addChild:showMembersScene];
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
                                    NSLog(@"%@", success);
                                    if (!error) {
                                        if(currentMessages < success.count)
                                        {
                                            [[messages_scroll contentNode] removeAllChildren];
                                            for (int i = 0; i < success.count; i++) {
                                                if ([success[i][@"user"] isEqualToString: currentUser[@"username"]]) {
                                                    
                                                    MyselfMessage *mm = (MyselfMessage*) [CCBReader load:@"MyselfMessage"];
                                                    mm.message = success[i][@"chatInfo"];
                                                    mm.owner = success[i][@"user"];
                                                    mm.positionType = CCPositionTypeNormalized;
                                                    mm.position = CGPointMake(0.68, i * 0.08);
                                                    [[messages_scroll contentNode] addChild:mm];
                                                } else {
                                                    OtherMessage *om = (OtherMessage*) [CCBReader load:@"OtherMessage"];
                                                    om.message = success[i][@"chatInfo"];
                                                    om.owner = success[i][@"user"];
                                                    om.positionType = CCPositionTypeNormalized;
                                                    om.position = CGPointMake(0.3, i * 0.08);
                                                    [[messages_scroll contentNode] addChild:om];
                                                }
                                                while (currentMessages < success.count) {
                                                    currentMessages++;
                                                }
                                            }
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
