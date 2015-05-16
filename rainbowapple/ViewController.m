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
@property (nonatomic, strong) SPTAudioStreamingController *player;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)togglePlayback:(id)sender {
    SPTSession *session = [AppDelegate sharedAppDelegate].session;
    if(self.player.isPlaying) {
        [self pauseUsingSession:session];
    } else {
        [self playUsingSession:session];
    }
}


- (void)updateButton {
    if(self.player.isPlaying) {
        [self.playButton setTitle:@"pause" forState:UIControlStateNormal];
    } else {
        [self.playButton setTitle:@"play" forState:UIControlStateNormal];
    }
}

-(void) pauseUsingSession:(SPTSession *)session {
    __weak typeof (self) weakself = self;
    [self.player setIsPlaying:NO callback:^(NSError *error) {
        typeof (weakself) self = weakself;
        if (error != nil) {
            NSLog(@"*** Pausing music got error: %@", error);
            return;
        }
        
        [self updateButton];
    }];
}

-(void)playUsingSession:(SPTSession *)session {
    
    // Create a new player if needed
    if (self.player == nil) {
        self.player = [[SPTAudioStreamingController alloc] initWithClientId:[SPTAuth defaultInstance].clientID];
    }
    
    [self.player loginWithSession:session callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Logging in got error: %@", error);
            return;
        }
        
        NSURL *trackURI = [NSURL URLWithString:@"spotify:track:58s6EuEYJdlb0kO7awm3Vp"];
        [self.player playURIs:@[ trackURI ] fromIndex:0 callback:^(NSError *error) {
            if (error != nil) {
                NSLog(@"*** Starting playback got error: %@", error);
                return;
            }
            [self updateButton];
        }];
    }];
}

@end
