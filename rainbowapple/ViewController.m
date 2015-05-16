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

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIButton *playButton;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSURL *trackURI = [NSURL URLWithString:@"spotify:track:58s6EuEYJdlb0kO7awm3Vp"];
    [self setPlaybackContextToUri:trackURI];
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
    [self setPlayback:![AppDelegate sharedAppDelegate].player.isPlaying];
}


- (void)updateButton {
    if([AppDelegate sharedAppDelegate].player.isPlaying) {
        [self.playButton setTitle:@"pause" forState:UIControlStateNormal];
    } else {
        [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    }
}

-(void) setPlayback:(BOOL)play {
    __weak typeof (self) weakself = self;
    [[AppDelegate sharedAppDelegate].player setIsPlaying:play callback:^(NSError *error) {
        typeof (weakself) self = weakself;
        if (error != nil) {
            NSLog(@"*** Pausing music got error: %@", error);
            return;
        }
        
        [self updateButton];
    }];
}

-(void)setPlaybackContextToUri:(NSURL *)trackURI {
    [[AppDelegate sharedAppDelegate].player replaceURIs:@[ trackURI ] withCurrentTrack:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Starting playback got error: %@", error);
            return;
        }
    }];
}

@end
