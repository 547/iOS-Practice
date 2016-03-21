//
//  MyOperation.h
//  MySellfDoOperation
//
//  Created by mac on 16/2/29.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol MyOperationDelegate;
//自定义operation==blockoperation==invacationoperation
@interface MyOperation : NSOperation
@property(nonatomic,assign)id<MyOperationDelegate>delegate;
-(id)downLoadImageWithurl:(NSString *)aUrlString delegate:(id<MyOperationDelegate>)aDelegate;
@property(nonatomic,copy)NSString *urlString;
@end
@protocol MyOperationDelegate <NSObject>

-(void)getImage:(UIImage *)image;

@end