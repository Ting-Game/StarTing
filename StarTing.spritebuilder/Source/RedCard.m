//
//  CCSprite+RedCard.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "RedCard.h"
#import <Parse/Parse.h>
#import "ZoomRed.h"

@implementation RedCard{
    CCLabelTTF *Keyword_TTF;
    CCLabelTTF *Detail_TTF;
}

- (void)onEnter{
    [super onEnter];
    Keyword_TTF.string = self.keyword;
    Detail_TTF.string = @"";
    self.userInteractionEnabled = YES;
}

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    
    // Get game status
    [PFCloud callFunctionInBackground:@"getGameStatus"
                       withParameters:@{@"gameID" : self.gameID}
                                block:^(PFObject *success, NSError *error) {
                                    if (!error) {
                                        // Get game status
                                        [PFCloud callFunctionInBackground:@"getGameStatus"
                                                           withParameters:@{@"gameID" : self.gameID}
                                                                    block:^(PFObject *success, NSError *error) {
                                                                        if (!error) {
                                                                            NSNumber *started = success[@"started"];
                                                                            if ([started doubleValue] != 0) {
                                                                                ZoomRed *zoomRed = (ZoomRed*)[CCBReader load:@"ZoomRed"];
                                                                                zoomRed.keyword = self.keyword;
                                                                                zoomRed.detail = self.detail;
                                                                                zoomRed.RedNum = self.RedNum;
                                                                                zoomRed.gameID = self.gameID;
                                                                                zoomRed.positionType = CCPositionTypeNormalized;
                                                                                zoomRed.position = CGPointMake(0.5, 0.5);
                                                                                zoomRed.scale = 2.4;
                                                                                [self.parent.parent addChild:zoomRed];
                                                                            }
                                                                        }
                                                                    }];
                                        
                                        //                                        NSString *judger = success[@"judger"];
                                        //                                        if ([judger isEqualToString: name]) {
                                        //                                            [PFCloud callFunctionInBackground:@"selectBest"
                                        //                                                               withParameters:@{@"gameID" : self.gameID, @"bestNo" : self.RedNum}
                                        //                                                                        block:^(NSArray *success, NSError *error) {
                                        //                                                                            if (!error) {
                                        //
                                        //                                                                            }
                                        //                                                                        }];
                                        //
                                        //                                        } else {
                                        //                                            [PFCloud callFunctionInBackground:@"selectRed"
                                        //                                                               withParameters:@{@"gameID" : self.gameID, @"redNum" : self.RedNum}
                                        //                                                                        block:^(NSArray *success, NSError *error) {
                                        //                                                                            if (!error) {
                                        //                                                                                
                                        //                                                                            }
                                        //                                                                        }];
                                        //                                        }
                                    }
                                }];
}

@end
