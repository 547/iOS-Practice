//
//  ViewController.m
//  SocketTest
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Seven. All rights reserved.
//

#import "ViewController.h"
//导入头文件
#import <sys/socket.h>//发送数据
#import <netinet/in.h>
#import <arpa/inet.h>
@interface ViewController ()

@end

@implementation ViewController

{
    int myClientSocket;//套接字的描述符
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self socketCreate];
}
#pragma mark==1.创建socket函数==套接字的描述符
-(void)socketCreate
{
    /*
     1.创建socket函数
     socket(AF_INET, SOCK_STREAM, IPPROTO_TCP)
     参数1：协议域，又称协议族（family），协议族决定了socket的地址类型。常用的协议域有：AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合；AF_INET6 ipv6、AF_LOCAL或AF_UNIX决定了要用一个绝对路径名作为地址
     参数2：socket类型
     常用的socket类型有：
        SOCK_STREAM=流式Socket=针对于面向连接的TCP服务应用；
        SOCK_DGRAM 数据报式Socket 对应于无连接的UDP服务应用
     参数3：指定协议与socket类型对应。如果传入0会根据第二个参数选择合适的值。
     常用的协议有IPPROTO_TCP（TCP传输协议），IPPROTO_UDP(UDP传输协议)
     返回值：如果调用成功就返回新创建的套接字的描述符（套接字描述符是一个整数类型的值），如果失败就返回-1
     */
    myClientSocket=socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
    
    [self connact];
}
#pragma mark==2.连接到服务器
-(void)connact
{
    /*
     2.connect连接到服务器
     connect(<#int#>, <#const struct sockaddr *#>, <#socklen_t#>)
     参数1：套接字描述符
     参数2：指向结构体sockaddr_in的指针，其中包括目的端口和IP地址等
     参数3：参数二的sockaddr的长度，可以通过sizeof(struct sockaddr)获得
     返回值：连接成功就返回0，失败非0，错误码GetLastError（）。
     */
    /*
     结构体： struct sockaddr_in {
     __uint8_t sin_len;
     sa_family_t sin_family;  //类型：IPV4类型
     in_port_t sin_port;  //端口号，要使用大尾顺序（各个计算机CPU型号不同，存储的顺序也会不同，htons()函数会将各个计算机统一为网络需要的大尾顺序）
     struct in_addr sin_addr;  //IP地址，无符号长整型数字，调用结构体中s_addr，通过inet_addr()函数可以转换字符串
     char sin_zero[8];
     };
     
     */
    struct sockaddr_in addr;//结构体
    addr.sin_family=AF_INET;//类型：IPV4类型
    addr.sin_addr.s_addr=inet_addr("http://www.baidu.com");//IP地址，无符号长整型数字，调用结构体中s_addr，通过inet_addr()函数可以转换字符串
    addr.sin_port=htons(8080);//端口号，要使用大尾顺序（各个计算机CPU型号不同，存储的顺序也会不同，htons()函数会将各个计算机统一为网络需要的大尾顺序）
    
    
    int result = connect(myClientSocket, (const struct sockaddr *) &addr, sizeof(addr));
    if (result!=0) {
        NSLog(@"连接失败");
    }else{
        NSLog(@"连接成功");
        [self sentData];
        [self receiveData];
    }
}
#pragma mark==3.发送数据
/*
 作用：用来将数据由指定的 socket 传给对方主机。使用 send 时套接字必须已经连接。send 不包含传送失败的提示信息，如果检测到本地错误将返回-1。因此，如果send 成功返回，并不必然表示连接另一端的进程接收数据。所保证的仅是当send 成功返回时，数据已经无错误地发送到网络上。
 */
-(void)sentData
{
    /*
     发送数据到服务器：
     send(<#int#>, <#const void *#>, <#size_t#>, <#int#>)
     参数1：指定发送端套接字描述符
     参数2：指明一个存放应用程式要发送数据的缓冲区（要发送的数据）
     参数3：指明实际要发送的数据的字符个数，注意：是字符char个数 strlen()，不能是字节数sizeof ( )
     参数4：是否阻塞，一般填0
     返回值：成功则返回实际传送出去的字符数ssize_t类型的，失败返回－1，错误原因存于errno 中
     */
//    const char *ch=@"54545".UTF8String;//字符串转字符
    const char *msg="接收到数据了吗？";//要发送的数据
    
    ssize_t sendCount = send(myClientSocket, msg, strlen(msg), 0);
    NSLog(@"发送的字节数%zd",sendCount);
}
#pragma mark==4.接收数据
-(void)receiveData
{
    /*
     接收服务器返回的数据
     recv(<#int#>, <#void *#>, <#size_t#>, <#int#>)
     参数1：套接字描述符
     参数2：存放接收到的数据字节的数组，uint8_t类型（可以通过NSData的dataWithBytes:方法将字节（Bytes）转换为Data数据）
     参数3：存放字节的数组大小
     参数4：是否阻塞，一般填0
     返回值：若无错误发生，返回值为读入的字节数。如果连接已中止，返回0。否则的话，返回SOCKET_ERROR错误，应用程序可通过WSAGetLastError()获取相应错误代码
     */
    
    uint8_t buffer[1024];//接收服务器返回的数据
    NSMutableData *receData=[NSMutableData data];
    ssize_t receCount = recv(myClientSocket, buffer, sizeof(buffer), 0);
    NSLog(@"接收的字节数%zd",receCount);
    [receData appendBytes:buffer length:receCount];//服务器会返回多次数据，等所有的数据都接收完成后，在转换成字符串
    NSString *receStr=[[NSString alloc]initWithData:receData encoding:NSUTF8StringEncoding];//data转换成字符串
    NSLog(@"接收到的字符串：%@",receStr);
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
