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
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateButton];
    self.navigationController.navigationBar.topItem.title = @"AppName";
}

- (void) initializePlayback{
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)togglePlayback:(id)sender {
    [Player setPlayback:![AppDelegate sharedAppDelegate].player.isPlaying];
    [self updateButton];
}


- (void)updateButton {
    if([AppDelegate sharedAppDelegate].player.isPlaying) {
        [self.playButton setTitle:@"pause" forState:UIControlStateNormal];
    } else {
        [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    }
}





@end
