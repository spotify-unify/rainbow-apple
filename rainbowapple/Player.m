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

+(void)initializePlaybackForURIs:(NSArray*)uris shouldPause:(BOOL)pause controller:(ViewController *) controller{
    [[AppDelegate sharedAppDelegate].player playURIs:uris fromIndex:0 callback:^(NSError *error) {
        if(error != nil) {
            NSLog(@"*** Playing music got error: %@", error);
            return;
        }
        if (pause) {
          [Player setPlayback:NO controller:nil];
        } else {
            [Player setPlayback:YES controller:nil];
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
        
        if(controller != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [controller updateUI];
            });
        }
    }];
}

+(void) setPlayback:(BOOL)play controller:(ViewController *) controller {
    [[AppDelegate sharedAppDelegate].player setIsPlaying:play callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Pausing music got error: %@", error);
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [controller updateUI];
        });
    }];
}


@end
