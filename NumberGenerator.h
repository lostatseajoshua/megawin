//
//  NumberGenerator.h
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/5/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumberGenerator : NSObject

@property (strong,nonatomic) NSNumber *number1;
@property (strong, nonatomic) NSNumber *number2;
@property (strong, nonatomic) NSNumber *number3;
@property (strong, nonatomic) NSNumber *number4;
@property (strong, nonatomic) NSNumber *number5;
@property (strong, nonatomic) NSNumber *megaball;
@property (strong, nonatomic) NSMutableArray *winningNumbers;

-(void)generateMegaMillionsNumbers;

@end
