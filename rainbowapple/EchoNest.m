//
//  EchoNest.m

#import "EchoNest.h"

@interface EchoNest ()

@end

@implementation EchoNest

// Get artists from a city
+(NSArray*) searchArtistByCity:(NSString*)city {

    // Get artists and their top songs for a city
    NSString* urlString = [NSString stringWithFormat:@"%@/%@", @"http://developer.echonest.com/api/v4/artist/search?api_key=WKBSEDFABLGIDIMSK%20&format=json&results=15&bucket=id:spotify&bucket=songs&artist_location=city:", city];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:requestHandler options:0 error:&localError];
    
    // Get the artists (and their songs)
    NSArray* artistsData = [[parsedObject valueForKey:@"response"] valueForKey:@"artists"];
    
    
    // Create an array for top songs
    NSMutableArray* topSongs = [NSMutableArray new];
    
    // Loop through artists data
    for (NSDictionary* artistData in artistsData) {
        
        // They have multiple songs, so we need to pick the first
        NSArray *songs = artistData[@"songs"];
        NSDictionary *firstSong = songs.firstObject;
        
        // Add their top song ID to an array. We're adding their ECHONEST id to our array
        [topSongs addObject:[firstSong valueForKey:@"id"]];
    }

    return topSongs;
}
                            
/*get spotify ID for a song, returns array of spotify song ids
+(NSArray*) searchSongBySongId:(NSString*)songId {
    
    NSString* urlString = [NSString stringWithFormat:@"%@/%@", @"http://developer.echonest.com/api/v4/song/profile?api_key=WKBSEDFABLGIDIMSK&format=json&id=SOWSUIP13DBDB01AE7&bucket=tracks&bucket=id%3Aspotify-WW&:", songId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:requestHandler options:0 error:&localError];
    NSArray* songData = [parsedObject valueForKey:@"response"];

    NSArray *tracks = dict[@"tracks"];
    NSDictionary *firstTrack = tracks.firstObject;
    
    if (firstTrack != nil)
    {
        NSURL * songUrl = [NSURL URLWithString:firstTrack[@"foreign_id"]];
    }
    
    return songUrl;
}*/


@end
