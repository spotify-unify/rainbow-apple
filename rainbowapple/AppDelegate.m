#import <Spotify/Spotify.h>
#import "AppDelegate.h"

@interface AppDelegate ()
@property (nonatomic, strong, readwrite) SPTSession *session;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[SPTAuth defaultInstance] setClientID:@"4e15b6a8af1644119124bc95b57235d5"];
    [[SPTAuth defaultInstance] setRedirectURL:[NSURL URLWithString:@"rainbowapple:/callback"]];
    [[SPTAuth defaultInstance] setRequestedScopes:@[SPTAuthStreamingScope]];
    
    // Construct a login URL and open it
    NSURL *loginURL = [[SPTAuth defaultInstance] loginURL];
    
    // Opening a URL in Safari close to application launch may trigger
    // an iOS bug, so we wait a bit before doing so.
    [application performSelector:@selector(openURL:)
                      withObject:loginURL afterDelay:0.1];
    return YES;
}

// Handle auth callback
-(BOOL)application:(UIApplication *)application
           openURL:(NSURL *)url
 sourceApplication:(NSString *)sourceApplication
        annotation:(id)annotation {
    
    // Ask SPTAuth if the URL given is a Spotify authentication callback
    if ([[SPTAuth defaultInstance] canHandleURL:url]) {
        [[SPTAuth defaultInstance] handleAuthCallbackWithTriggeredAuthURL:url callback:^(NSError *error, SPTSession *session) {
            
            if (error != nil) {
                NSLog(@"*** Auth error: %@", error);
                return;
            }
            
            self.session = session;
        }];
        return YES;
    }
    
    return NO;
}

+ (instancetype)sharedAppDelegate {
    return [UIApplication sharedApplication].delegate;
}

@end