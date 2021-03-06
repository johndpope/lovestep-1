//
//  MidiButton.h
//  lovestep
//
//  Created by Raymond Kennedy on 12/1/13.
//  Copyright (c) 2013 Zachary Waleed Saraf. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#define BASE_KEY 24

@interface MidiButton : NSButton

@property (nonatomic) BOOL isWhiteKey;
@property (nonatomic) NSString *keyName;
@property (nonatomic, strong) NSMutableArray *gridButtons;
@property (nonatomic) float frequency;
@property (nonatomic) NSInteger keyNumber;

- (id)initWithKeyNumber:(NSInteger)keyNumber target:(id)target mouseDownSEL:(SEL)mouseDownSEL mouseUpSEL:(SEL)mouseUpSEL;
- (void)changeKeyNameTo:(NSString *)keyName;
- (void)changeKeyNameToDefault;

@end
