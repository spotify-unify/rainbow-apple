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
    [self changeBgImage:@"bg_w_gradient.jpg"];
    self.navigationController.navigationBar.topItem.title = @"Pilgrim";
    [self.playButtonLabel setText:@"Explore"];
    [self.city setText:@"Rio De Janeiro"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)changeBgImage:(NSString*)imageName {
    [self.background setImage:[UIImage imageNamed:imageName]];
}

- (IBAction)skipNext:(id)sender {
    [Player nextTrack:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)togglePlayback:(id)sender {
    BOOL isPlaying = [AppDelegate sharedAppDelegate].player.isPlaying;
    [Player setPlayback:!isPlaying controller:self];
}

- (void) updateSongLabel {
    [SPTTrack trackWithURI:[Player currentlyPlayingTrack] session:[AppDelegate sharedAppDelegate].session callback:^(NSError *error, id track) {
        if(error != nil) {
            NSLog(@"*** Unable to find song name for url: %@", error);
            return;
        }
        [self.playButtonLabel setText:[track name]];
    }];
}

- (void)updateButton {
    BOOL isPlaying = [AppDelegate sharedAppDelegate].player.isPlaying;
    if(isPlaying) {
        [self changeImageOfPlayButton:@"pause"];
    } else {
        [self changeImageOfPlayButton:@"play_wo_explore"];
    }
}

-(void)changeImageOfPlayButton:(NSString*)image {
    [self.playButton setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
}

-(void)updateUI {
    [self updateSongLabel];
    [self updateButton];
}



@end
