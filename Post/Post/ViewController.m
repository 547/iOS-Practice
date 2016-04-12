//
//  ViewController.m
//  Post
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
    
    
    
    //post请求
    //http://localhost:8080/WebTest/NewServlet?name=admin&password=123
    //post请求要求不带参数的URL
    //创建一个不带参数的URl
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/WebTest/NewServlet"];
    //post数据要追加到请求数据体内
     NSString *nameAndPassWord=@"name=admin&password=123";
    //如果请求的字段中出现中文不管是get还是post都要先对中文进行编码处理
    //处理方法如下
//    [nameAndPassWord stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //字符串转成数据
    NSData *data=[nameAndPassWord dataUsingEncoding:NSUTF8StringEncoding];
    //创建请求对象：可变的 因为要后续追加数据
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:url];
    //追加请求数据
    [request setHTTPBody:data];
    //由于数据量有时过大，可以设置超时时间
    [request setTimeoutInterval:30];
    //设置请求方式
    [request setHTTPMethod:@"POST"];
    //发起请求===异步请求
    [NSURLConnection connectionWithRequest:request delegate:self];
}
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"error=====%@",error);
}
//服务器开始做出响应
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    _dataBuffer=[[NSMutableData alloc]initWithCapacity:0];
    //创建关于HTTP响应信息的对象
    NSHTTPURLResponse *httpResponse=(NSHTTPURLResponse *)response;
    NSLog(@"response==statusCode===%ld====所有信息+++%@",(long)[httpResponse statusCode],[httpResponse allHeaderFields]);
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_dataBuffer appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *string=[[NSString alloc]initWithData:_dataBuffer encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tongBu:(id)sender {
    
    //同步请求
     //http://localhost:8080/WebTest/NewServlet?name=admin&password=123
    NSURL *url=[NSURL URLWithString:@"http://localhost:8080/WebTest/NewServlet?name=admin&password=123"];
    NSURLRequest *request=[[NSURLRequest alloc]initWithURL:url];
    /*
     Asynchronous==异步
     sendAsynchronousRequest==请求对象
     queue ==操作线程
     completionHandler==
     */
    //异步请求
//    NSData *data=[NSURLConnection sendAsynchronousRequest:<#(nonnull NSURLRequest *)#> queue:<#(nonnull NSOperationQueue *)#> completionHandler:<#^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError)handler#>];
    /*
     同步请求三要素
     sendSynchronousRequest==请求数据
     returningResponse==响应信息（状态行、状态码、响应数据）==双指针
     error==错误原因==双指针
     */
    //同步请求
    NSURLResponse *response=nil;
    NSError *error=nil;
    //sendSynchronousRequest返回data数据类型
    NSData *data=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSString *str=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //输出响应数据
    NSLog(@"同步请求+++++++====%@",str);
}

- (IBAction)yiBu:(id)sender {
}
@end
