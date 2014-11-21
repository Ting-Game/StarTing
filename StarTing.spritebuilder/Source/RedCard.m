//
//  CCSprite+RedCard.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "RedCard.h"
#import <Parse/Parse.h>

@implementation RedCard{
    CCTextField *Keyword_TTF;
    CCTextField *Detail_TTF;
}

- (void)onEnter{
    [super onEnter];
    Keyword_TTF.string = self.keyword;
    Detail_TTF.string = self.detail;
    self.userInteractionEnabled = YES;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
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
                                                                                
                                                                            }
                                                                        }];

                                        } else {
                                            [PFCloud callFunctionInBackground:@"selectRed"
                                                               withParameters:@{@"gameID" : self.gameID, @"redNum" : self.RedNum}
                                                                        block:^(NSArray *success, NSError *error) {
                                                                            if (!error) {
                                                                                
                                                                            }
                                                                        }];
                                        }
                                    }
                                }];
}

@end
