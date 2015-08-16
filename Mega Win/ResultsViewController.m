//
//  ResultsViewController.m
//  Mega Winner
//
//  Created by Joshua Alvarado on 3/5/14.
//  Copyright (c) 2014 Joshua Alvarado. All rights reserved.
//

#import "ResultsViewController.h"

@interface ResultsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel1;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel2;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel3;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel4;
@property (weak, nonatomic) IBOutlet UILabel *numbersLabel5;
@property (weak, nonatomic) IBOutlet UIButton *megamillionsButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fetchingResultsIndicatorView;
@property (strong, nonatomic) NSURLConnection *connection;
@property BOOL didMethodFinish;
@end

@implementation ResultsViewController

- (IBAction)backButton:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

float expectedTotalSize;
//https://data.ny.gov/resource/5xaw-6ayf.json?%24order=draw_date%20DESC&%24limit=5

- (void)fetchMegamillionsResults {
    self.megamillionsButton.enabled = NO;
    NSString *currentURL = @"https://getbible.net/json?p=James";
    NSURL *url = [NSURL URLWithString:currentURL];
    NSData *data = [[NSData alloc]initWithContentsOfURL:url];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    NSMutableData *receivedData = [[NSMutableData alloc] initWithLength:0];
    NSURLConnection * connection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self startImmediately:YES];
    
    [receivedData setLength:0];
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:url MIMEType:@".json" expectedContentLength:-1 textEncodingName:nil];
    expectedTotalSize = [response expectedContentLength];
        
    if ([data length] !=0) {
        NSLog(@"appendingData");
        [receivedData appendData:data];

    if(connection){
        NSLog(@"Succeeded! Received %lu bytes of data",(unsigned long)[receivedData length]);
    }
    
    NSError * error;
    NSMutableDictionary  * json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
    
    if(json){
        NSMutableArray *winningNumbersArray = [[NSMutableArray alloc]init];
        NSMutableArray *drawDatesArray = [[NSMutableArray alloc]init];
        NSMutableArray *megaBallArray = [[NSMutableArray alloc]init];
        NSMutableArray *multiplierArray = [[NSMutableArray alloc]init];
        
        NSArray *responseArr = [json mutableCopy];
        
        //NSLog(@"%@", responseArr);
        for (int i = 0; i< 5; i++) {
            winningNumbersArray[i] = [responseArr[i] valueForKey:@"winning_numbers"];
            drawDatesArray[i] = [responseArr[i] valueForKey:@"draw_date"];
            megaBallArray[i] = [responseArr[i] valueForKey:@"mega_ball"];
            multiplierArray[i] = [responseArr[i] valueForKey:@"multiplier"];
        }
        self.numbersLabel1.text = [[NSString alloc]initWithFormat:@"Date: %@\nNumbers: %@\nMegaBall: %@ Multiplier: %@", drawDatesArray[0], winningNumbersArray[0], megaBallArray[0], multiplierArray[0]];
        self.numbersLabel2.text = [[NSString alloc]initWithFormat:@"Date: %@\nNumbers: %@\nMegaBall: %@ Multiplier: %@", drawDatesArray[1], winningNumbersArray[1], megaBallArray[1], multiplierArray[1]];
        self.numbersLabel3.text = [[NSString alloc]initWithFormat:@"Date: %@\nNumbers: %@\nMegaBall: %@ Multiplier: %@", drawDatesArray[2], winningNumbersArray[2], megaBallArray[2], multiplierArray[2]];
        self.numbersLabel4.text = [[NSString alloc]initWithFormat:@"Date: %@\nNumbers: %@\nMegaBall: %@ Multiplier: %@", drawDatesArray[3], winningNumbersArray[3], megaBallArray[3], multiplierArray[3]];
        self.numbersLabel5.text = [[NSString alloc]initWithFormat:@"Date: %@\nNumbers: %@\nMegaBall: %@ Multiplier: %@", drawDatesArray[4], winningNumbersArray[4], megaBallArray[4], multiplierArray[4]];
        [self labelsFadeIn];
    }else if (!json){
        self.numbersLabel1.text = [[NSString alloc]initWithFormat:@"Error: No internet connection"];
        [self labelsFadeIn];
     }
   }
    if ([data length] == 0) {
        self.numbersLabel1.text = [[NSString alloc]initWithFormat:@"Error! Could not recieve data from server"];
        self.numbersLabel2.text = [[NSString alloc]initWithFormat:@"Possibilites:"];
        self.numbersLabel3.text = [[NSString alloc]initWithFormat:@"No internet connection, Server Update, Server Issues"];
        self.numbersLabel4.text = [[NSString alloc]initWithFormat:@"Please Email developer if problem persist"];
        self.numbersLabel5.text = [[NSString alloc]initWithFormat:@"Very sorry about the problem, Try again later."];
        [self labelsFadeIn];

    }
}

- (IBAction)getMegaMillionsResults:(UIButton *)sender {
    [self.fetchingResultsIndicatorView startAnimating];
    [self performSelectorInBackground:@selector(fetchMegamillionsResults)  withObject:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    BOOL areSoundEffectsOn = [defaults boolForKey:@"soundEffects"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (areSoundEffectsOn) {
        [self buttonPlaySound];
    }
    
    sender.enabled = NO;
    self.title = @"Mega Millions";
}
-(void)labelsFadeIn
{
    self.numbersLabel1.alpha = 0.0;
    self.numbersLabel2.alpha = 0.0;
    self.numbersLabel3.alpha = 0.0;
    self.numbersLabel4.alpha = 0.0;
    self.numbersLabel5.alpha = 0.0;
    
    self.numbersLabel1.hidden = NO;
    self.numbersLabel2.hidden = NO;
    self.numbersLabel3.hidden = NO;
    self.numbersLabel4.hidden = NO;
    self.numbersLabel5.hidden = NO;
    
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:
     ^{
         self.numbersLabel1.alpha = 1;
         self.numbersLabel2.alpha = 1;
         self.numbersLabel3.alpha = 1;
         self.numbersLabel4.alpha = 1;
         self.numbersLabel5.alpha = 1;
     } completion:nil];
    [self.fetchingResultsIndicatorView stopAnimating];
    if(!self.megamillionsButton.enabled){
        self.megamillionsButton.enabled = YES;
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)buttonPlaySound
{
    NSString *effectTitle = @"alienSound";
    
    SystemSoundID soundID;
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:effectTitle ofType:@"mp3"];
    NSURL *soundUrl = [NSURL fileURLWithPath:soundPath];
    
    AudioServicesCreateSystemSoundID ((__bridge CFURLRef)soundUrl, &soundID);
    AudioServicesPlaySystemSound(soundID);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.numbersLabel1.hidden = YES;
    self.numbersLabel2.hidden = YES;
    self.numbersLabel3.hidden = YES;
    self.numbersLabel4.hidden = YES;
    self.numbersLabel5.hidden = YES;
    [self labelsFadeIn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
