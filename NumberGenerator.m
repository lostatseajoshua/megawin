//
//  NumberGenerator.m
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/5/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "NumberGenerator.h"

@implementation NumberGenerator

-(void)generateMegaMillionsNumbers
{
    static const int lowestNumber = 1;
    static const int highestNumber = 75;
    static const int megaLow = 1;
    static const int megaHigh = 15;
    NSMutableSet *set = [NSMutableSet set];
    while ([set count] < 5) {
        [set addObject:@((arc4random() % (highestNumber-lowestNumber+1)) + lowestNumber)];
    }
    NSArray *myArray = [set allObjects];
    self.number1 = myArray[0];
    self.number2 = myArray[1];
    self.number3 = myArray[2];
    self.number4 = myArray[3];
    self.number5 = myArray[4];
    self.megaball = [[NSNumber alloc]initWithInt:((arc4random() % (megaHigh-megaLow+1)) + megaLow)];
    self.winningNumbers = [[NSMutableArray alloc]initWithObjects:self.number1,self.number2,self.number3,self.number4,self.number5, nil];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [self.winningNumbers sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    for (int i = 0; i < self.winningNumbers.count; i++) {
        NSLog(@"%@ ", self.winningNumbers[i]);
    }
    NSLog(@"\n");
}

@end
