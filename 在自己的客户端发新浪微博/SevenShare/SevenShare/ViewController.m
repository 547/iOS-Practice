//
//  ViewController.m
//  SevenShare
//
//  Created by mac on 16/2/23.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
#import "PostRequest.h"
#import "ASIFormDataRequest.h"
@interface ViewController ()<UIWebViewDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate,ASIHTTPRequestDelegate>

@end

@implementation ViewController
{
    NSMutableData *dataBuffer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self initUI];
    
    
    
}
-(void)initUI
{
    
    //https://api.weibo.com/oauth2/authorize?client_id=3869885678&response_type=code&redirect_uri=http://www.taobao.com
    
    /*
     client_id===填写APP Key===3869885678
     redirect_uri====应用信息中的高级信息中的授权回调页的URL==www.taobao.com
     */
    //1.引导用户到登录页、授权页===到授权页的目的是为了获取code，只用获取到了code才可以进一步获取到Access_token，有了Access_token就可以实现发微博、评论、获取用户的所有信息
    UIWebView *weiBoWeb = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:weiBoWeb];
    NSURLRequest *weiBoRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.weibo.com/oauth2/authorize?client_id=3869885678&response_type=code&redirect_uri=https://api.weibo.com/oauth2/default.html"]];
    
    weiBoWeb.delegate=self;//开启代理是为了在协议方法里面把网页上加载的数据获取到
    
    [weiBoWeb loadRequest:weiBoRequest];
    
}
#pragma mark===UIWebView的代理方法==这个方法不会提示
//2.检测到webView开始解读请求的时候调用
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    //request.URL.absoluteString==此次请求的URL上面的全部信息
//    NSLog(@"=====%@",request.URL.absoluteString);
    
    //http://www.taobao.com/?code=d00ca20c8eb383fab20ae7f1cbcfb138
    //3.先判断URL中是否包含code字段===rangeOfString==返回一个NSRange结构体===该结构体包含length、location
  NSRange range = [request.URL.absoluteString rangeOfString:@"code"];
    
    
    if (range.length>0) {
        //如果range的长度大于0表示此次返回的URl中有code字段，可以截取code的信息
       NSArray *codeArray = [request.URL.absoluteString componentsSeparatedByString:@"="];//分割字符串
//        NSLog(@"=+++++++%@",codeArray);
        //5.获取到code
      NSString *codeString = [codeArray lastObject];//至此，新浪微博返回的web页已经全部结束了，接下来的一切请求都将以接口文档上面的get或者Post方式去完成
//        NSLog(@"------%@",codeString);
        
        
        /**
         client_id==APP Key
         client_secret==App Secret
         redirect_uri===授权回调页
         code==上面获取的code
         有了这些参数就可以向新浪发一个Post请求，来获取Access_token了
         **/
        //post请求的请求参数
          NSString *str =[NSString stringWithFormat:@"client_id=3869885678&client_secret=df6f3306721ae1d0daf78c07a7bd6aa6&grant_type=authorization_code&redirect_uri=https://api.weibo.com/oauth2/default.html&code=%@",codeString];
//        [self getAccess_token:str urlString:@"https://api.weibo.com/oauth2/access_token"];
        
        
        //6.发Post请求获取Access_token
        PostRequest *post =[[PostRequest alloc]init];
        
        [post sentPostRequest:@"https://api.weibo.com/oauth2/access_token" requestBody:str requestTag:100];
        post.delegate=self;
    }
    
    return YES;
}
#pragma mark===PostRequest的代理方法

-(void)PostRequest:(NSMutableData *)requestData request:(MyMutableURLRequest *)request
{
    //7.新浪返回给我们的是一个JSON，所以要先做JSON解析成一个字典
  NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:requestData options:NSJSONReadingAllowFragments error:nil];
//    NSLog(@"======22=====%@",[dic objectForKey:@"access_token"]);
    //前面
    if (request.tag == 100) {
        NSString *access_token = [dic objectForKey:@"access_token"];
        
        
//        NSString *str =[NSString stringWithFormat:@"access_token=%@&status=这是测试信息",access_token];
        //发送一个纯文字的微博
//        PostRequest *post =[[PostRequest alloc]init];
//        [post sentPostRequest:@"https://api.weibo.com/2/statuses/update.json" requestBody:str requestTag:101];
//        post.delegate=self;
        
        UIImage *im=[UIImage imageNamed:@"5.png"];
        NSData *data =UIImagePNGRepresentation(im);

                //发送一个图文结合的微博
        ASIFormDataRequest *post =[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"https://upload.api.weibo.com/2/statuses/upload.json"]];
        [post addData:data forKey:@"pic"];
        [post addPostValue:access_token forKey:@"access_token"];
        [post addPostValue:@"微博API测试" forKey:@"status"];
        post.delegate=self;
        [post startAsynchronous];

    }
    if (request.tag == 101) {
        NSLog(@"4444=====%@",dic);
    }
}
-(void)requestFinished:(ASIHTTPRequest *)request
{
   NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"=====%@",dic);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
