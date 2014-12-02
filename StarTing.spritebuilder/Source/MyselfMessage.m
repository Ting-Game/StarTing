//
//  CCNode+MyselfMessage.m
//  StarTing
//
//  Created by Yuefeng Wu on 11/30/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

#import "MyselfMessage.h"

@implementation MyselfMessage{
    CCLabelTTF *message_TTF;
    CCLabelTTF *owner_TTF;
}

- (void)onEnter{
    [super onEnter];
    message_TTF.string = self.message;
    owner_TTF.string = self.owner;
}

@end
