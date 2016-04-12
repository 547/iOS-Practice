//
//  ViewController.m
//  ASITest
//
//  Created by mac on 16/2/22.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "ASIHTTPRequest.h"//get请求，下载用的类
#import "ASIFormDataRequest.h"//post请求，上传用的类
#import "Reachability.h"//检测当前网络连接状态
@interface ViewController ()<ASIHTTPRequestDelegate>
@end

@implementation ViewController
{

    ASIHTTPRequest *requestDown;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.downLoadProgress.progress=0;
}
- (IBAction)getButton:(UIButton *)sender {
    //发get请求
    /**
    1.创建请求对象
     **/
   ASIHTTPRequest *_request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    //2.开启代理，在代理中捕捉请求的结果
    _request.delegate = self;
    
    _request.timeOutSeconds = 30;//设置超时时间
    
    
    /*
     [_request startSynchronous];==同步请求
     [_request startAsynchronous];==异步请求
     [_request start];==默认异步请求
     */
    //3.发起请求==默认异步请求==发起请求同步、异步的区别就在于调用的方法不同
    [_request startAsynchronous];
    
    
}
- (IBAction)postButton:(UIButton *)sender {
    //发post请求
    //1.创建一个Post请求===ASIFormDataRequest
   ASIFormDataRequest *_dataRequest = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://localhost:8080/A/a"]];
    //2.在请求后面追加数据的方法addPostValue前面的参数是值，后面的是
    [_dataRequest addPostValue:@"0" forKey:@"command"];
    [_dataRequest addPostValue:@"11" forKey:@"name"];
    [_dataRequest addPostValue:@"111" forKey:@"psw"];
    //3.开代理：asi不管是get、post 同步、异步都只调用一套方法
    [_dataRequest setDelegate:self];
    _dataRequest.timeOutSeconds = 20;
    //4.发送请求
    [_dataRequest startAsynchronous];
}
//上传
- (IBAction)updataButton:(UIButton *)sender {
    
    //http://localhost:8080/上传服务器/upload
    
    
    //1.获取要上传的东西的路径，并转化为data类型的，因为Post请求追加数据的数据类型是data类型的
   NSString *path = [[NSBundle mainBundle]pathForResource:@"5" ofType:@"png"];
    NSData *data = [[NSData alloc]initWithContentsOfFile:path];
    //2.创建一个Post请求===ASIFormDataRequest
    NSString *urlString = @"http://localhost:8080/上传服务器/upload";
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    //3.在Post请求中追加数据===appendPostData
    [request appendPostData:data];
    //设置代理===代理可以不开也可以实现上传
//    [request setDelegate:self];
    
    request.uploadProgressDelegate = self;//设置uploadProgressDelegate代理，可以设置、获取上传下载的进度，不需要这些数据的话，可以不用设置这个代理
    
    //5.发送请求
    [request startAsynchronous];
    
}

//检测当前网络连接状态
- (IBAction)chaKanWangLuoButton:(UIButton *)sender {
    
    //初始化的时候给检测类一个有效的URl，通过连接该Url来测试网络状态
    Reachability *reachNetWork = [Reachability reachabilityWithHostName:@"http://www.baidu.com"];
    
    //获取当前检测到的状态枚举
    NetworkStatus status = [reachNetWork currentReachabilityStatus];
    /**
     NotReachable     = kNotReachable,===没有网
     ReachableViaWiFi = kReachableViaWiFi,===wifi
     ReachableViaWWAN = kReachableViaWWAN====有网
     **/
    switch (status) {
        case NotReachable:
            NSLog(@"没有网");
            break;
        case ReachableViaWiFi:
            NSLog(@"wifi");
            break;
        case ReachableViaWWAN:
            NSLog(@"有网");
            break;

        default:
            break;
    }
    
}

//断点续存
- (IBAction)duanDianDownLoadButton:(UIButton *)sender {
    //http://localhost:8080/downloadServer/
    /**
     ASI断点下载的原理：ASI断点下载在文件还没下载好之前都会存储到开发者提供的临时路径下，当检测到下载完毕之后会把临时文件里面的文件移到开发者提供的完成路径下，开发者只需要提供对应的路径，而断点下载的逻辑ASI已经封装好了
     **/
    
    
    NSString *urlStr=@"http://localhost:8080/downloadServer/点菜.mov.zip";
    urlStr=[urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //1.创建一个请求对象ASIHTTPRequest
    requestDown = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlStr]];
    
    //2.创建一个文件临时存储路径==缓存路径
    NSString *pathStr=[self getfilePath:@"tmp/点菜.mov.zip"];
    //3.创建一个存储完成路径
    NSString *desPathStr= [self getfilePath:@"Documents/点菜.mov.zip"];
    
    //4.设置文件下载完存放的地址
    requestDown.downloadDestinationPath = desPathStr;
    //5.设置文件下载完之前存放的地址==缓存地址
    requestDown.temporaryFileDownloadPath =pathStr;
    
    
    //开启代理===进度代理，可以不开启
    requestDown.downloadProgressDelegate=self;
    
    //开启代理==可以不开启，也能下载成功
//    requestDown.delegate=self;
    
    //6.allowResumeForFileDownloads==允许断点下载==Resume==继续
    requestDown.allowResumeForFileDownloads=YES;
    //7.发请求=异步A
    [requestDown startAsynchronous];
    
}
//取消下载
- (IBAction)cancelButton:(UIButton *)sender {
    [requestDown cancel];//取消下载
}

//获取存储路径
-(NSString *)getfilePath:(NSString *)fileName
{
//   return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0]stringByAppendingPathComponent:fileName];
   NSString *str = NSHomeDirectory();
    return [str stringByAppendingPathComponent:fileName];

}
#pragma mark===ASIHTTPRequestDelegate代理方法
//开始请求
-(void)requestStarted:(ASIHTTPRequest *)request
{
    NSLog(@"开始请求");

}
//请求失败==如断网
-(void)requestFailed:(ASIHTTPRequest *)request
{
NSLog(@"请求失败");
}
//接收到响应头
-(void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
NSLog(@"接收到响应头");
}
//接收服务器返回的数据===这个方法和requestFinished不能同时调用，如果调用这个方法就等于告诉系统要自己接受数据，不使用系统自动帮我们接收的数据responseData或responseString，那么在requestFinished中打印的responseData或responseString的就会是null的
//-(void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
//{
//    NSLog(@"接收服务器返回的数据");
//
//}
//请求结束
-(void)requestFinished:(ASIHTTPRequest *)request
{
    /*
     返回数据
     request.responseData===服务器返回的是数据源类型
     request.responseString====服务器返回的字符数据类型
     */
        NSLog(@"++++%@",request.responseData);
        NSLog(@"++111++%@",request.responseString);
}
//重新发送请求
//-(void)requestRedirected:(ASIHTTPRequest *)request
//{
//
//}
//通过URL重新发送请求
//-(void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
//{
//
//}.

#pragma mark====uploadProgressDelegate===代理方法
//设置进度，获取进度
- (void)setProgress:(float)newProgress
{
    NSLog(@"当前上传进度：%f",newProgress);
    //设置显示的进度
    [self.downLoadProgress setProgress:newProgress animated:YES];
    
    NSString *str=@"%";
    //设置显示的进度
    self.progressLabel.text=[NSString stringWithFormat:@"%0.2f%@",newProgress*100,str];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
