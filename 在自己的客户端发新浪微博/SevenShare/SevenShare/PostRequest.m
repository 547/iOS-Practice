//
//  GetRequest.m
//  SevenShare
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "PostRequest.h"

@implementation PostRequest
{
    NSMutableData *dataBuffer;
    MyMutableURLRequest *request;
}
-(void)sentPostRequestWithData:(NSString *)urlString requestBodyPic:(NSData *)requestBodyPic requestBodyStatus:(NSString *)requestBodyStatus requestBodyAccess_token:(NSString *)requestBodyAccess_token requestTag:(int)requestTag
{
    request = [MyMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.tag=requestTag;
    [request setHTTPMethod:@"Post"];
    
    [request setValue:requestBodyPic forKey:@"pic"];
    [request setValue:requestBodyStatus forKey:@"status"];
    [request setValue:requestBodyAccess_token forKey:@"access_token"];
    [request setTimeoutInterval:30];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)sentPostRequest:(NSString *)urlString requestBody:(NSString *)requestBody requestTag:(int)requestTag
{
    request = [MyMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.tag=requestTag;
    [request setHTTPMethod:@"Post"];
  
    [request setTimeoutInterval:30];
    
    [request setHTTPBody:[requestBody dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error===%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    dataBuffer =[[NSMutableData alloc]init];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataBuffer appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.delegate PostRequest:dataBuffer request:request];
    
}
@end
