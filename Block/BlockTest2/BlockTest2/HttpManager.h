//
//  HttpManager.h
//  BlockTest2
//
//  Created by mac on 16/2/25.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIFormDataRequest.h"
@interface HttpManager : NSObject<ASIHTTPRequestDelegate>

//描述Block的时候一定要用copy，避免循环引用
@property(nonatomic,copy)void(^httpBlock)(ASIHTTPRequest *request1);
-(void)setRequestWithUrl:(NSString *)urlString;
@end
