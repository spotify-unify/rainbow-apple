//
//  EchoNest.m

#import "EchoNest.h"

@interface EchoNest ()

@end

@implementation EchoNest

// Function to query EchoNest API and return songs, given a location
//+(NSArray*) searchSongByLocation:(double)min_latitude : (double)min_longitude {
-(NSArray*) searchSongByLatitude:(double)min_latitude longitude:
(double)min_longitude {

    NSString* urlString = [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/song/search?api_key=WKBSEDFABLGIDIMSK&format=json&results=15&min_latitude=%f&min_longitude=%f&bucket=id:spotify&bucket=audio_summary&bucket=tracks", min_latitude, min_longitude];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:requestHandler options:0 error:&localError];
    
    /* Get the songs from the echonest data */
    NSArray* songsData = [parsedObject valueForKeyPath:@"response.songs"];
    NSMutableArray* songs = [NSMutableArray new];
    
    /* For each song, add their name to a new array */
    for (NSDictionary* dict in songsData) {
        NSArray *tracks = dict[@"tracks"];
        NSDictionary *firstTrack = tracks.firstObject;
        
        if (firstTrack != nil)
        {
            [songs addObject:firstTrack[@"foreign_id"]];
        }
        
    }
    
    /* Print array */
    NSLog(@"songs = %@", songs);

    return songs;
}


@end
