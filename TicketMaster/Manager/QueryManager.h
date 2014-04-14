//
//  QueryManager.h
//  EarthQuakism
//
//  Created by Yoon Lee on 3/30/14.
//  Copyright (c) 2014 Yoon Lee. All rights reserved.
//

#import <Foundation/Foundation.h>
// borrowed fastest JSON serializer class from github
#import "JSONKit.h"

@protocol QueryManagerDelegate;

@interface QueryManager : NSObject<NSURLConnectionDataDelegate>
{
    id<QueryManagerDelegate> delegate;
}
@property(nonatomic, assign)id<QueryManagerDelegate> delegate;

- (void)shakeEQ:(NSString*)keyword;
// excuting the query
- (void)executeQuery;

@end

@protocol QueryManagerDelegate
- (void)didReceivedResponseFromQueryManager:(QueryManager*)qm withResponse:(id)response;
@end
