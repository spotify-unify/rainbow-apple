//
//  AppDelegate.h
//  rainbowapple
//
//  Created by Tom Macmichael on 16/05/2015.
//  Copyright (c) 2015 Spotify Unify. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SPTAudioStreamingController;
@class SPTSession;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong, readonly) SPTAudioStreamingController *player;
@property (nonatomic, strong, readonly) SPTSession *session;
+ (instancetype)sharedAppDelegate;

@end

