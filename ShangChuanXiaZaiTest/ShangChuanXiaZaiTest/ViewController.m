//
//  ViewController.m
//  ShangChuanXiaZaiTest
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSMutableData *_dataBuffer;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSLog(@"%@",NSHomeDirectory());
}
- (IBAction)shangchuan:(id)sender {
   
    
    //上传===难点在服务器，客户端只要确保请求和数据发送成功
/*
 上传步骤：
 1.获取上传资源
 2.获取上传Url
 3.POST请求
 */
    NSData *imageData=[[NSData alloc]initWithContentsOfFile:[self getFilePath:@"1.jpg"]];
    NSString *str=@"http://localhost:8080/上传服务器/upload";
   str= [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //post请求
    NSMutableURLRequest *requst=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:str]];
    //设置超时间
    [requst setTimeoutInterval:30];
    //设置请求方式
    [requst setHTTPMethod:@"Post"];
    
    [requst addValue:@"multipart-from-data" forHTTPHeaderField:@"Content-Type"];
    //追加数据
    [requst setHTTPBody:imageData];
    NSURLResponse *response=nil;
    NSError *error=nil;
    [NSURLConnection sendSynchronousRequest:requst returningResponse:&response error:&error];
    //PS:如果Url里面有中文不管是get还是Post都要编码
    //http://localhost:8080/上传服务器/upload
    
    
     /*
      上传大文件：上传的时候出现中断问题牵扯到断点续传逻辑由服务器去完成
      */
    NSString *pathString=[[NSBundle mainBundle]pathForResource:@"视频合集" ofType:@"mp4"];
    
}

- (IBAction)xiazai:(id)sender {
    //下载
    //下载dizhttp://pic.nipic.com/2007-11-09/200711912453162_2.jpg
//    NSString *str=@"http://pic.nipic.com/2007-11-09/200711912453162_2.jpg";
    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://pic.nipic.com/2007-11-09/200711912453162_2.jpg"]] delegate:self];
//    [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _dataBuffer=[[NSMutableData alloc]initWithCapacity:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_dataBuffer appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //把网络图片显示出来
    self.myInage.image=[UIImage imageWithData:_dataBuffer];
    [_dataBuffer writeToFile:[self getFilePath:@"1.jpg"] atomically:YES];
}
-(NSString *)getFilePath:(NSString *)fileName
{
    NSString *str=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSLog(@"----%@",str);
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:fileName];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
