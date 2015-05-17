#import <Spotify/Spotify.h>
#import "AppDelegate.h"
#import "EchoNest.h"
#import "Player.h"

@interface AppDelegate ()
@property (nonatomic, strong, readwrite) SPTSession *session;
@property (nonatomic, strong, readwrite) SPTAudioStreamingController *player;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
    [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor colorWithRed:0.25 green:0.75 blue:0.79 alpha:1]};
    
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
            [self loginWithSession:session];
        }];
        return YES;
    }
    
    return NO;
}

-(NSArray *)getSongsForCity:(NSString*)city {
    EchoNest *echoNest = [EchoNest new];
    // Get the songs for our city. This gives us echonest Ids
    NSArray *songsFromCity = [EchoNest searchArtistByCity:city];
    NSArray* shuffledSongs = [self shuffleSongs:[songsFromCity mutableCopy]];
    return shuffledSongs;
}

-(NSArray*)shuffleSongs:(NSMutableArray*) array{
    srandom(time(NULL));
    for (NSInteger x = 0; x < [array count]; x++) {
        NSInteger randInt = (random() % ([array count] - x)) + x;
        [array exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return array;
}

+ (instancetype)sharedAppDelegate {
    return [UIApplication sharedApplication].delegate;
}

-(void)loginWithSession:(SPTSession *)session {
    // Create a new player if needed
    if (self.player == nil) {
        self.player = [[SPTAudioStreamingController alloc] initWithClientId:[SPTAuth defaultInstance].clientID];
    }
    
    [self.player loginWithSession:session callback:^(NSError *error) {
        if (error != nil) {
            NSLog(@"*** Logging in got error: %@", error);
            return;
        }
        
        self.session = session;
        [self playSongsForCity:@"Stockholm" shouldPause:YES controller:nil];
    }];
}

-(void)playSongsForCity:(NSString*)city shouldPause:(BOOL)shouldPause controller:(ViewController*)controller{
    NSArray *uris = [self getSongsForCity:city];
    [Player initializePlaybackForURIs:uris shouldPause:shouldPause controller:controller];
}


@end