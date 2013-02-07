//
//  PalInstructionViewController.m
//  PalCard
//
//  Created by FlyinGeek on 13-2-5.
//  Copyright (c) 2013年 FlyinGeek. All rights reserved.
//


#import "PalInstructionViewController.h"
#import "MCSoundBoard.h"

#define _BGPIC "UIimages/main_bg.jpg"
#define _BGPIC2 "UIimages/cloud-front.png"
#define _BGPIC3 "UIimages/cloud-back.png"
#define _LOGOPIC "UIimages/main_logo.png"

#define DEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)




@interface PalInstructionViewController (){
    bool _soundOff;
}

@property (strong, nonatomic) IBOutlet UIImageView *bgPic;
@property (strong, nonatomic) IBOutlet UIImageView *bgPic2;
@property (strong, nonatomic) IBOutlet UIButton *returnButton;
@property (strong, nonatomic) IBOutlet UIImageView *blackBG;
@property (strong, nonatomic) IBOutlet UIImageView *infoBG;
@property (strong, nonatomic) IBOutlet UIImageView *easyView;
@property (strong, nonatomic) IBOutlet UIImageView *normalView;
@property (strong, nonatomic) IBOutlet UIImageView *hardView;
@property (strong, nonatomic) IBOutlet UITextView *text1;
@property (strong, nonatomic) IBOutlet UITextView *text2;
@property (strong, nonatomic) IBOutlet UITextView *text3;

@end

@implementation PalInstructionViewController




- (void)prepare
{
    // prepare method 是用来放映背景云和山跑马灯效果
    
    
    self.blackBG.alpha = 1.0;
    
    self.bgPic.image  = [UIImage imageNamed:@_BGPIC];
    self.bgPic2.image = [UIImage imageNamed:@_BGPIC2];
    
    self.bgPic2.alpha = 0.7;
    
    
    // mountain
    
    CGRect frame = self.bgPic.frame;
    frame.origin.x = 0;
    self.bgPic.frame = frame;
    
    [UIView beginAnimations:@"testAnimation" context:NULL];
    [UIView setAnimationDuration:20.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:9999];
    
    frame = self.bgPic.frame;
    frame.origin.x = -frame.size.width + 320;
    self.bgPic.frame = frame;
    
    [UIView commitAnimations];
    
    // cloud
    
    CGRect frame2 = self.bgPic2.frame;
    frame2.origin.x = 0;
    self.bgPic2.frame = frame2;
    
    [UIView beginAnimations:@"testAnimation2" context:NULL];
    [UIView setAnimationDuration:8.0];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationRepeatAutoreverses:NO];
    [UIView setAnimationRepeatCount:9999];
    
    frame2 = self.bgPic2.frame;
    frame2.origin.x = -frame2.size.width + 285;
    self.bgPic2.frame = frame2;
    
    [UIView commitAnimations];
    
    
    [UIView beginAnimations:@"fadeIn" context:nil];
    [UIView setAnimationDuration:0.5];
    self.blackBG.alpha = 0.0f;
    [UIView commitAnimations];
    
    
    
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:UIApplicationWillEnterForegroundNotification object:nil];
    
	[self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
    
	[self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) refresh{
    
    [self prepare];
    //NSLog(@"trigger event when will enter foreground.");
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
    
    
    if (!DEVICE_IS_IPHONE5) {
        
        [self.easyView setFrame:CGRectMake(30, 20, 130, 78)];
        [self.normalView setFrame:CGRectMake(30, 130, 130, 78)];
        [self.hardView setFrame:CGRectMake(30, 260, 130, 78)];
        
        [self.text1 setFrame:CGRectMake(40, 70, 240, 70)];
        [self.text2 setFrame:CGRectMake(40, 182, 240, 95)];
        [self.text3 setFrame:CGRectMake(40, 310, 240, 95)];
        
        [self.infoBG setFrame:CGRectMake(-10, 5, 340, 440)];
        
        [self.returnButton setFrame:CGRectMake(250, 425, 50, 35)];
    }
    
    
    self.easyView.image = [UIImage imageNamed:@"UIimages/easy.png"];
    self.normalView.image = [UIImage imageNamed:@"UIimages/normal.png"];
    self.hardView.image = [UIImage imageNamed:@"UIimages/hard.png"];
    
    
    NSString *turnOffSound = [[NSUserDefaults standardUserDefaults] valueForKey:@"turnOffSound"];
    
    if (turnOffSound) {
        
        if ([turnOffSound isEqualToString:@"YES"]) {
            _soundOff = YES;
        }
        else if ([turnOffSound isEqualToString:@"NO"]) {
            _soundOff = NO;
        }
    }
    else {
        _soundOff = NO;
    }
    
    if (!_soundOff) {
        [MCSoundBoard addSoundAtPath:[[NSBundle mainBundle] pathForResource:@"botton_pressed.wav" ofType:nil] forKey:@"botton"];
    }
    
    
    [self.returnButton setBackgroundImage:[UIImage imageNamed:@"UIimages/back.png"] forState:UIControlStateNormal];
    
    [self.returnButton setBackgroundImage:[UIImage imageNamed:@"UIimages/back_push.png"] forState:UIControlStateHighlighted];
    
    self.infoBG.image = [UIImage imageNamed:@"UIimages/info_bg.png"];
    
    [self prepare];
    
}

-(void) viewDidDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setBgPic:nil];
    [self setBgPic2:nil];
    [self setReturnButton:nil];
    [self setBlackBG:nil];
    [self setInfoBG:nil];
    [self setEasyView:nil];
    [self setNormalView:nil];
    [self setHardView:nil];
    [self setText1:nil];
    [self setText2:nil];
    [self setText3:nil];
    [super viewDidUnload];
}

- (IBAction)returnButtonPressed:(UIButton *)sender {
    
    if (!_soundOff) {
        [MCSoundBoard playSoundForKey:@"botton"];
    }
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
    
}


@end