//
//  CCNode+ZoomRed.m
//  StarTing
//
//  Created by Yuefeng Wu on 12/1/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "ZoomRed.h"
#import <Parse/Parse.h>

@implementation ZoomRed

- (void)onEnter{
    [super onEnter];
    
    CCLabelTTF *keyword = [CCLabelTTF node];
    keyword.fontName = @"Sansation-BoldItalic.ttf";
    keyword.fontSize = 14.f;
    keyword.string = self.keyword;
    keyword.anchorPoint = CGPointMake(0.5, 0.5);
    keyword.positionType = CCPositionTypeNormalized;
    keyword.position = CGPointMake(0.5, 0.3);
    keyword.color = [CCColor colorWithRed:1.f green:1.f blue:1.f];
    [self addChild:keyword];
    
    CCLabelTTF *detail = [CCLabelTTF node];
//    detail.fontName = @"Sansation-BoldItalic.ttf";
    detail.fontSize = 4.f;
    detail.string = self.detail;
    detail.anchorPoint = CGPointMake(0.5, 0.5);
    detail.positionType = CCPositionTypeNormalized;
    detail.position = CGPointMake(0.5, 0.15);
    detail.color = [CCColor colorWithRed:0.f green:0.f blue:0.f];
    [self addChild:detail];
}

- (void)back_button{
    [self removeFromParent];
}

- (void)select_button{
    PFUser *currentUser = [PFUser currentUser];
    NSString *name = currentUser[@"username"];
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        
                                        NSString *judger = success[@"judger"];
                                        if ([judger isEqualToString: name]) {
                                            [PFCloud callFunctionInBackground:@"selectBest"
                                                               withParameters:@{@"gameID" : self.gameID, @"bestNo" : self.RedNum}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                [self removeFromParent];
                                                                            }
                                                                        }];
                                            
                                        } else {
                                            [PFCloud callFunctionInBackground:@"selectRed"
                                                               withParameters:@{@"gameID" : self.gameID, @"redNum" : self.RedNum}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                [self removeFromParent];
                                                                            }
                                                                        }];
                                        }
                                    }
                                }];
}

@end
