//
//  GenerateNumbersViewController.m
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/5/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "GenerateNumbersViewController.h"


@interface GenerateNumbersViewController ()
@property (weak, nonatomic) IBOutlet UIButton *generateButton;
@property (weak, nonatomic) IBOutlet UIButton *saveNumbersButton;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel;
@property (strong, nonatomic) NumberGenerator *numberGenerator;

@end

@implementation GenerateNumbersViewController

- (NSManagedObjectContext *)managedObjectContext
{
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}
-(NumberGenerator *)numberGenerator{
    if(!_numberGenerator) _numberGenerator = [[NumberGenerator alloc]init];
    return _numberGenerator;
}
- (IBAction)generateNumbers:(UIButton *)sender {
    [self.numberGenerator generateMegaMillionsNumbers];
    self.numbersLabel.text = [[NSString alloc] initWithFormat:@"%@ %@ %@ %@ %@ \n Megaball:%@", self.numberGenerator.winningNumbers[0], self.numberGenerator.winningNumbers[1], self.numberGenerator.winningNumbers[2], self.numberGenerator.winningNumbers[3], self.numberGenerator.winningNumbers[4], self.numberGenerator.megaball];

    self.saveNumbersButton.enabled = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (areSoundEffectsOn) {
        [self buttonPlaySound];
    }
}
- (IBAction)saveNumbers:(UIButton *)sender {
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    [self.numberGenerator.winningNumbers sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSManagedObject *newNumber = [NSEntityDescription insertNewObjectForEntityForName:@"Numbers" inManagedObjectContext:context];

    [newNumber setValue:[[NSString alloc] initWithFormat:@"%@ %@ %@ %@ %@\nMegaball:%@ ", self.numberGenerator.winningNumbers[0],self.numberGenerator.winningNumbers[1],self.numberGenerator.winningNumbers[2],self.numberGenerator.winningNumbers[3],self.numberGenerator.winningNumbers[4],self.numberGenerator.megaball] forKey:@"number"];
    
    NSError *error = nil;
    
    //Save the object to persistent store
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    sender.enabled = NO;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (areSoundEffectsOn) {
        [self buttonPlaySaveSound];
    }
}

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIColor* lightblueColor = [UIColor colorWithRed:0xD1/255.0f
                                          green:0xEE/255.0f
                                           blue:0xFC/255.0f alpha:1];
    UIColor* redColor = [UIColor colorWithRed:0xFF/255.0f
                                          green:0x3A/255.0f
                                           blue:0x2D/255.0f alpha:1];
    self.generateButton.backgroundColor = lightblueColor;
    self.saveNumbersButton.backgroundColor = redColor;
    self.saveNumbersButton.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)buttonPlaySound
{
    NSString *effectTitle = @"electronicWaterDrop";
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}
-(void)buttonPlaySaveSound
{
    NSString *effectTitle = @"quickStickHit";
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}
@end
