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
        
        // We've got the echonestId for the song now
        NSString *echoNestId = [firstSong valueForKey:@"id"];
        
        // We just need to get the spotify song ID now using our other function
        NSString *spotifyUri = [self getSpotifyUriForSong:echoNestId];
        
        if (spotifyUri != nil)
        {
            // add this to our array
            [topSongs addObject:spotifyUri];
        }
    }

    return topSongs;
}
                            
//get spotify ID for a song, returns array of spotify song ids
+(NSURL*) getSpotifyUriForSong:(NSString*)songId {
    
    // Create request URL
    NSString* urlString = [NSString stringWithFormat:@"http://developer.echonest.com/api/v4/song/profile?api_key=WKBSEDFABLGIDIMSK&format=json&bucket=tracks&bucket=id:spotify-WW&id=%@", songId];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:requestHandler options:0 error:&localError];
    
    // Get the song data
    NSArray* songData = [[[parsedObject valueForKey:@"response"] valueForKey:@"songs"] valueForKey:@"tracks"];
    
    // We only care about the first track, so extract tha
    NSURL *songUrl = nil;
    
    // First check if there are any tracks
    if ([[songData objectAtIndex:0] count] != 0)
    {
        NSDictionary *firstTrack = [[songData objectAtIndex:0] objectAtIndex:0];
        
        if (firstTrack != nil)
        {
            songUrl = [NSURL URLWithString:firstTrack[@"foreign_id"]];
        }
    }
    
    
    return songUrl;
}


@end
