//
//  TrackFetcher
#import <Spotify/Spotify.h>

#import "TrackFetcher.h"
#import "EchoNest.h"



@interface TrackFetcher ()

@end

@implementation TrackFetcher

/*+(NSString*) artistURIFromName:(NSString*)artistName (NSSession*) session {
    [SPTRequest performSearchWithQuery:artistName queryType:SPTQueryTypeArtist offset:0 session:session callback:^(NSError *error, (SPTListPage*) object) {
        return nil;
    }
    
    return nil;
}*/

+(NSArray*) searchTracksByCity:(NSString*)city {
    NSArray* artists = [EchoNest searchArtistByCity:city];
    
    
    NSLog(@"artists = %@", artists);
    
    return artists;
}

@end
