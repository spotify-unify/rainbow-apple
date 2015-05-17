//
//  Player.h
//  rainbowapple
//
//  Created by Martin Barksten on 16/05/15.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import <UIKit/UIKit.h>

@class ViewController;

@interface Player : NSObject
+(void)initializePlaybackForURIs:(NSArray*)uris;
+(void) setPlayback:(BOOL)play controller:(ViewController*) controller;
+(void) setUrisForPlayback:(NSArray*)uris;
+(NSURL*) currentlyPlayingTrack;
+(void) nextTrack:(ViewController*) controller;
@end
