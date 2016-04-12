//
//  ViewController.m
//  XuanZeXiangCeTuPian
//
//  Created by mac on 16/2/19.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)shangChuan:(UIButton *)sender {
    //上传
    NSLog(@"=====%@",self.myImage.image);
    //上传大小文件的步骤如下：
    //目的服务器的Url
    NSString *urlString=@"http://localhost:8080/上传服务器/upload";
    //如果url中存在中文就要先用这个方法将nsstring先编码==stringByAddingPercentEscapesUsingEncoding
    urlString=[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //发Post请求一定要创一个可变的请求，因为Post请求不能带参数，后面要在请求追加请求数据（setHTTPBody），所以要创建成可变请求
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:[NSURL URLWithString:urlString]];
    //设置请求超时时间
    [request setTimeoutInterval:30];
    //设置请求HTTP方式
    [request setHTTPMethod:@"Post"];
    //追加请求数据==就是要上传或下载的东西
    /*
     上传小文件使用[request setHTTPBody:data];==setHttpBody方法；
     上传应用中的图片：
     NSData *data= UIImagePNGRepresentation(uiimage)===将image转nsdata的方法
     [request setHTTPBody:data];
     上传本地数据：
     NSData *data =[[NSData alloc]initWithContentsOfFile:[self getFilePath]];
     [request setHTTPBody:data];
     上传资源束中的数据：
     NSString *path =[[NSBundle mainBundle]pathForResource:@"meinv" ofType:@"jpg"];
     NSData *pathData =[path dataUsingEncoding:NSUTF8StringEncoding];
     [request setHTTPBody:pathData];
     */
    /*
     上传大文件
     如果是上传大文件就只要将setHTTPBody方法改变为[request setHTTPBodyStream:<#(NSInputStream * _Nullable)#>];其他步骤不变
     上传应用中的图片：
     NSData *data= UIImagePNGRepresentation(uiimage)===将image转nsdata的方法
     NSInputStream *stream =[NSInputStream inputStreamWithData:data];===将data转为输入流的方法
     [request setHTTPBodyStream:stream];
     上传本地数据：
     NSData *data =[[NSData alloc]initWithContentsOfFile:[self getFilePath]];
     NSInputStream *stream =[NSInputStream inputStreamWithData:data];===将data转为输入流的方法
     [request setHTTPBodyStream:stream];
     上传资源束中的数据：
     NSString *path =[[NSBundle mainBundle]pathForResource:@"meinv" ofType:@"jpg"];
     NSData *data =[path dataUsingEncoding:NSUTF8StringEncoding];==将string转data的方法
     NSInputStream *stream =[NSInputStream inputStreamWithData:data];===将data转为输入流的方法
     [request setHTTPBodyStream:stream];
     */
    [request setHTTPBody:UIImagePNGRepresentation(self.myImage.image)];
    //上传东西必须要写的==告诉服务器将要上传的东西的类型以及要追加到哪一部分
    [request addValue:@"multipart-from-data" forHTTPHeaderField:@"Content-Type"];
    //步骤发送一个异步请求
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * response, NSData *data, NSError *connectionError) {
        NSLog(@"122333");
    }];
}
- (IBAction)xuanZe:(UIButton *)sender {
    
    //选择图片
    //获取手机相册上的图片步骤如下：
    //1.创建一个ImagePickerController
    UIImagePickerController *imagePicker=[[UIImagePickerController alloc]init];
    /*
     2.设置资源类型==用这个属性==sourceType===
     UIImagePickerControllerSourceTypePhotoLibrary,==相册
     UIImagePickerControllerSourceTypeCamera,==相机
     UIImagePickerControllerSourceTypeSavedPhotosAlbum==手机中存储的图片
     */
    imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    //3.设置代理==PS：要声明两个代理：@interface ViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
    imagePicker.delegate=self;
    //4.模态弹出ImagePickerController
    [self presentViewController:imagePicker animated:YES completion:nil];
    //    UIAlertAction *alter=[[UIAlertAction alloc]init];
}
//5.实现UIImagePickerController的代理方法
//- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo
//{
//    NSLog(@"----%@",image);
//    self.myImage.image=image;
//}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    NSLog(@"%s====%@",__FUNCTION__,info);
    //在字典info中找到键名为“UIImagePickerControllerOriginalImage”的值，这个值就是一个UIImage
    UIImage *image=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [self dismissViewControllerAnimated:YES completion:^{
        self.myImage.image=image;
            }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
