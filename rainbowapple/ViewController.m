//
//  ViewController.m
//  rainbowapple
//
//  Created by Tom Macmichael on 16/05/2015.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import "ViewController.h"
#import <Spotify/Spotify.h>
#import "AppDelegate.h"
#import "Player.h"
#import "EchoNest.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@property (nonatomic, weak) IBOutlet UILabel *playButtonLabel;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateButton];
    self.navigationController.navigationBar.topItem.title = @"AppName";
    [self.playButtonLabel setText:@"Explore"];
}

- (void) initializePlayback{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)togglePlayback:(id)sender {
    [Player setPlayback:![AppDelegate sharedAppDelegate].player.isPlaying];
    [self.playButtonLabel setText:@"Currently playing song"];
    [self updateButton];
}


- (void)updateButton {
    
    if([AppDelegate sharedAppDelegate].player.isPlaying) {
        [self changeImageOfPlayButton:@"pause"];
    } else {
        [self changeImageOfPlayButton:@"play_wo_explore"];
    }
}

-(void)changeImageOfPlayButton:(NSString*)image {
    [self.playButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}





@end
