//
//  HttpManager.m
//  BlockTest2
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager
-(void)setRequestWithUrl:(NSString *)urlString
{
   __block ASIHTTPRequest *request=[ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
 
    [request startAsynchronous];
    //如果只是单纯的想要结果不考虑协议方法的情况下可以使用asi提供的Block方法，不用代理方法
    //成功（在Block内部访问的request是已经有数据的request）
    __block HttpManager *blSelf=self;
    [request setCompletionBlock:^{
        NSLog(@"=request====%@",request.responseString);
        blSelf.httpBlock(request);
    }];
    //失败
//    [request setFailedBlock:^{
//        <#code#>
//    }];
}
-(void)requestFinished:(ASIHTTPRequest *)request
{

    self.httpBlock(request);
}

@end
