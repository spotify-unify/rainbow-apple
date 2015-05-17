//
//  Player.m
//  rainbowapple
//
//  Created by Martin Barksten on 16/05/15.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import "Player.h"
#import <Spotify/Spotify.h>
#import "ViewController.h"

@implementation Player

+(void)initializePlaybackForURIs:(NSArray*)uris {
    [[AppDelegate sharedAppDelegate].player playURIs:uris fromIndex:0 callback:^(NSError *error) {
        if(error != nil) {
            NSLog(@"*** Playing music got error: %@", error);
            return;
        }
        
        [Player setPlayback:NO controller:nil];
    }];
}

+(void)setUrisForPlayback:(NSArray*)uris {
    [[AppDelegate sharedAppDelegate].player replaceURIs:uris withCurrentTrack:0 callback:^(NSError *error) {
        if(error != nil) {
            NSLog(@"*** Replacing songs gor error: %@", error);
            return;
        }
    }];
}

+(NSURL*)currentlyPlayingTrack {
    return [[AppDelegate sharedAppDelegate].player currentTrackURI];
}

+(void)setPlaybackContextToUri:(NSURL *)trackURI {
    [[AppDelegate sharedAppDelegate].player replaceURIs:@[ trackURI ] withCurrentTrack:0 callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Starting playback got error: %@", error);
            return;
        }
    }];
}

+(void)nextTrack:(ViewController *) controller {
    [[AppDelegate sharedAppDelegate].player skipNext:^(NSError *error) {
        if(error != nil) {
            NSLog(@"*** Skipping to next song got error: %@", error);
            return;
        }
        
        [controller updateUI];
    }];
}

+(void) setPlayback:(BOOL)play controller:(ViewController *) controller {
    [[AppDelegate sharedAppDelegate].player setIsPlaying:play callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Pausing music got error: %@", error);
            return;
        }
        
        if(controller != nil) {
            [controller updateUI];
        }
    }];
}


@end
