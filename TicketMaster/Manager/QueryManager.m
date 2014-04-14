//
//  QueryManager.m
//  EarthQuakism
//
//  Created by Yoon Lee on 3/30/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import "QueryManager.h"
#define EARTHQUAKE_DEFAULT_SEARCH_URI   @"http://api.seatgeek.com/2/events?q="
#define EARTHQUAKE_SAMEPLE_QUERY        @"clippers"

@interface QueryManager()

// mutable string has better performance on appending with other string
@property(nonatomic, retain)NSMutableString *query;
// i realized that message was sent to device by packet, and sometimes sealed by multiple its pieces. so that had to collect puzzled data.
@property(nonatomic, retain)NSMutableData *collection;

@end

@implementation QueryManager
@synthesize query;
@synthesize collection;
@synthesize delegate;

- (void)shakeEQ:(NSString*)keyword
{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self setQuery:[[[NSMutableString alloc] initWithString:EARTHQUAKE_DEFAULT_SEARCH_URI] autorelease]];
    // sending with parameters with keyword
    [self.query appendString:keyword];
}

- (void)executeQuery
{
    DLog(@"%@", query);
    collection = [[NSMutableData alloc] init];
    NSURL *uri = [NSURL URLWithString:[self.query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSURLRequest *request = [NSURLRequest requestWithURL:uri cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.f];
    NSURLConnection *connection = [[[NSURLConnection alloc]initWithRequest:request delegate:self startImmediately:YES] autorelease];
    [connection start];
}

#pragma mark NSURLConnectionDataDelegate

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // collecting data piece into one
    [collection appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *err = nil;
    id json = [collection objectFromJSONDataWithParseOptions:JKParseOptionNone error:&err];
    if (err) {
        DLog(@"%@", [err description]);
    }
    else {
        // post notification and hand over json object
        [self.delegate didReceivedResponseFromQueryManager:self withResponse:json];
    }
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

- (void)dealloc
{
    [super dealloc];
    
    [collection release];
    collection = nil;
}

@end
