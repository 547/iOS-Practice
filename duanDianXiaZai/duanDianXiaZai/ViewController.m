//
//  ViewController.m
//  duanDianXiaZai
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    NSURLConnection *connection;
    NSMutableData *dataBuffer;
    NSFileHandle *fileHandle;//句柄：可以查找文件的头部和尾部
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)quXiao:(id)sender {
    //取消下载
    [connection cancel];
    NSLog(@"取消下载");
}

- (IBAction)xiaZai:(id)sender {
    
    NSString *urlString=@"http://localhost:8080/downloadServer/点菜.mov.zip";
    urlString=[urlString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"Post"];
//    [NSURLConnection connectionWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] delegate:self];
    connection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
    
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    dataBuffer=[[NSMutableData alloc]init];
    NSLog(@"000");
    //句柄在使用的时候必须要准备一个真实存在的路径文件来初始化（）
//    fileHandle=[NSFileHandle fileHandleForReadingAtPath:[self getFilePath:@"upload.jpg"]];
    
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [dataBuffer appendData:data];
    
    NSLog(@"111");
//    [fileHandle seekToEndOfFile];
//    [fileHandle writeData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"222");
   [dataBuffer writeToFile:[self getFilePath:@"点菜.mov.zip"] atomically:YES];
    //关闭句柄
//    [fileHandle closeFile];
}

-(NSString *)getFilePath:(NSString *)fileName
{
//   NSString *path= [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:fileName];
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if (![fileManager fileExistsAtPath:path]) {
//        fileManager createFileAtPath:<#(nonnull NSString *)#> contents:<#(nullable NSData *)#> attributes:<#(nullable NSDictionary<NSString *,id> *)#>
//    }
   return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingString:fileName];
    
    
}
@end
