//
//  InitialViewController.m
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/5/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "InitialViewController.h"

@interface InitialViewController ()
@property (weak, nonatomic) IBOutlet UIButton *generateNumbersButton;
@property (weak, nonatomic) IBOutlet UIButton *resultsButton;
@property (weak, nonatomic) IBOutlet UIButton *savedNumbersButton;
@end

@implementation InitialViewController

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
    UIColor* greenColor = [UIColor colorWithRed:0x0B/255.0f
                                   green:0xD3/255.0f
                                    blue:0x18/255.0f alpha:1];
    UIColor* purpleColor = [UIColor colorWithRed:0x58/255.0f
                                   green:0x56/255.0f
                                    blue:0xD6/255.0f alpha:1];
    UIColor* blueColor = [UIColor colorWithRed:0x00/255.0f
                                   green:0x7A/255.0f
                                    blue:0xFF/255.0f alpha:1];
    self.generateNumbersButton.backgroundColor = greenColor;
    self.resultsButton.backgroundColor = purpleColor;
    self.savedNumbersButton.backgroundColor = blueColor;
}

-(void)awakeFromNib
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if(![defaults objectForKey:@"firstRun"])[defaults setBool:YES forKey:@"firstRun"];
    [defaults synchronize];
    if ([defaults boolForKey:@"firstRun"]) {
        [defaults setBool:YES forKey:@"soundEffects"];
        [defaults setBool:NO forKey:@"firstRun"];
        [defaults synchronize];
    }
    
    self.canDisplayBannerAds = YES;
    
    [super awakeFromNib];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"results"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        UIViewController *result = (UIViewController *)navigationController.topViewController;
            NSLog(@"insideInterstital");
            result.interstitialPresentationPolicy = ADInterstitialPresentationPolicyAutomatic;
    }
}

- (IBAction)playSoundOnClick:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (areSoundEffectsOn) {
        [self buttonPlaySound];
    }
}

-(void)buttonPlaySound
{
    NSString *effectTitle = @"coinDrop";
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}
@end
