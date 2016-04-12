//
//  GetRequest.h
//  SevenShare
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyMutableURLRequest.h"
@protocol PostRequestDelegate;
@interface PostRequest : NSObject<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
@property (nonatomic,assign)int tag;
@property (nonatomic,assign)id<PostRequestDelegate>delegate;
-(void)sentPostRequest:(NSString *)urlString requestBody:(NSString *)requestBody requestTag:(int)requestTag;
-(void)sentPostRequestWithData:(NSString *)urlString requestBodyPic:(NSData *)requestBodyPic requestBodyStatus:(NSString *)requestBodyStatus requestBodyAccess_token:(NSString *)requestBodyAccess_token requestTag:(int)requestTag;
@end
@protocol PostRequestDelegate <NSObject>

-(void)PostRequest:(NSMutableData *)requestData request:(MyMutableURLRequest *)request;

@end