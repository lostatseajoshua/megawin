//
//  InformationViewController.m
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/12/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *soundEffectsButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

@implementation InformationViewController

- (IBAction)back:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailDeveloper:(UIButton *)sender {
    NSString *subject = @"Mega Win Lite App Suppprt";
    NSString *body = @"\n\nEmailed from Mega Win App";
    NSString *path = [NSString stringWithFormat:@"mailto:puglifeapps@gmail.com?&subject=%@&body=%@", subject, body];
    NSURL *url = [NSURL URLWithString:[path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

- (IBAction)soundEffects:(UIButton *)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    if (areSoundEffectsOn == YES) {
        [defaults setBool:NO forKey:@"soundEffects"];
        [defaults synchronize];
        [sender setTitle:@"No Sound Effects" forState:UIControlStateNormal];
    }
    else if (areSoundEffectsOn == NO){
        [defaults setBool:YES forKey:@"soundEffects"];
        [defaults synchronize];
        [sender setTitle:@"Sound Effects On" forState:UIControlStateNormal];
        [self buttonPlaySound];
    }
}

-(void)updateUI
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    if (areSoundEffectsOn == NO) {
        [self.soundEffectsButton setTitle:@"No Sound Effects" forState:UIControlStateNormal];
    }
    else if (areSoundEffectsOn == YES){
        [self.soundEffectsButton setTitle:@"Sound Effects On" forState:UIControlStateNormal];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.textView.text = [[NSString alloc]initWithFormat:@"How to play Mega Millions®: \nPick six numbers, five different numbers from 1 to 75 and one number from 1 to 15 that will be the MegaBall. You win the jackpot by matching all six winning numbers in a drawing. Mega Millions drawings are held every Tuesday and Friday at 11:00 pm ET.\n\nDisclaimer: The drawing results for Mega Millions® lottery game represented in the Mega Win app are posted to be as accurate as possible if in chance the numbers may be incorrect we will not be held liable for any misunderstanding of winnings. Mega Win is not affilated or endorsed by Mega Millions® lottery game. Thank you for downloading our application and play responsibly."];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [self updateUI];
}

-(void)buttonPlaySound
{
    NSString *effectTitle = @"wazeSynth";
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}

@end
