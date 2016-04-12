//
//  ViewController.m
//  mYrequest
//
//  Created by mac on 16/2/17.
//  Copyright © 2016年 Xiyunpeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *_dataBuffer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //http://localhost:8080/WebTest/NewServlet?name=admin&password=123
    /*
     http协议
     localhost 主机地址（127.0.0.1）
     ：8080 端口号
     WeBTest 服务器名称
     NewServlet 资源位置名称
     ？后面是客户端要传递给服务器的具体参数，以&分割各个参数
     属于标准的get请求方式
     */
    
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/WebTest/NewServlet?name=admin&password=123"];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _dataBuffer=[[NSMutableData alloc]initWithCapacity:0];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error======%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [_dataBuffer appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *stringForData=[[NSString alloc]initWithData:_dataBuffer encoding:NSUTF8StringEncoding];
    NSLog(@"%@",stringForData);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
