//
//  Requester.m
//  instagramPrototype
//
//  Created by Flávio Marques on 04/12/16.
//  Copyright © 2016 com.prototypes. All rights reserved.
//

#import "Requester.h"
#import <AFNetworking.h>

#define INSTAGRAM_BASEREQUEST_URL @"https://api.instagram.com/v1/users"
#define INSTAGRAM_REQUEST_SELF_URL @"/self/?access_token="
#define INSTAGRAM_REQUEST_SELF_LATEST_URL @"/self/media/recent?access_token="

@implementation Requester


+(NSDictionary *) getUserData:(NSString *) token
{

    NSString *url = [NSString stringWithFormat:@"%@%@%@", INSTAGRAM_BASEREQUEST_URL, INSTAGRAM_REQUEST_SELF_URL, token, nil];
    NSDictionary *dic = [Requester GetRequest:url];
    
    
    return dic;
}

+(NSDictionary *) getRecentData:(NSString *) token
{
    NSString *url = [NSString stringWithFormat:@"%@%@%@", INSTAGRAM_BASEREQUEST_URL, INSTAGRAM_REQUEST_SELF_LATEST_URL, token, nil];
    NSDictionary *dic = [Requester GetRequest:url];
    
    return dic;
}



+(NSDictionary *) GetRequest:(NSString *)url
{
    NSURL *action_Url =[NSURL URLWithString:url];
    
    NSMutableURLRequest *action_Request = [[NSMutableURLRequest alloc] init];
    [action_Request setURL:action_Url];
    [action_Request setHTTPMethod:@"GET"];
    
    NSLog(@"GET request to %@", url, nil);
    
    NSURLResponse *action_response;
    NSError *error;
    NSData *action_Result = [NSURLConnection sendSynchronousRequest:action_Request returningResponse:&action_response error:&error];
    if (!action_Result)
    {
        NSLog(@"Error: %@", error);
        return nil;
    }
    else
    {
        NSDictionary *jsonObject=[NSJSONSerialization
                                  JSONObjectWithData:action_Result
                                  options:NSJSONReadingMutableLeaves
                                  error:nil];
        // NSLog(@"jsonObject is %@",jsonObject);
        return jsonObject;
    }
    
}
@end
