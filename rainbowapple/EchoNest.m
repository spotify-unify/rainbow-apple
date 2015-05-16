//
//  EchoNest.m

#import "EchoNest.h"

@interface EchoNest ()

@end

@implementation EchoNest

+(NSArray*) searchArtistByCity:(NSString*)city {

    NSString* urlString = [NSString stringWithFormat:@"%@/%@", @"http://developer.echonest.com/api/v4/artist/search?api_key=WKBSEDFABLGIDIMSK%20&format=json&results=15&artist_location=city:", city];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSURLResponse *requestResponse;
    NSData *requestHandler = [NSURLConnection sendSynchronousRequest:request returningResponse:&requestResponse error:nil];
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:requestHandler options:0 error:&localError];
    NSArray* artistsData = [[parsedObject valueForKey:@"response"] valueForKey:@"artists"];
    NSMutableArray* artists = [NSMutableArray new];
    for (NSDictionary* dict in artistsData) {
        [artists addObject:[dict valueForKey:@"name"]];
    }
    
    NSLog(@"artists = %@", artists);

    return artists;
}

@end
