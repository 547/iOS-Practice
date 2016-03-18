//
//  ViewController.h
//  SocketTest
//
//  Created by mac on 16/3/18.
//  Copyright © 2016年 Seven. All rights reserved.
//
/*
 socket的简单使用
 字数1849 阅读319 评论1 喜欢4
 概念
 socket又称“套接字”，socket在应用层和传输层之间，我们的应用层只要将数据传递给socket就可以了，socket会传递给传输层、网络层等。
 网络通信其实就是Socket之间的通信。
 数据在两个Socket之间通过IO传输数据。
 Socket是纯C语言的，是跨平台的。
 HTTP协议是基于Socket的，HTTP协议的底层使用的就是Socket
 
 socket的位置.png
 
 socket通信过程，使用步骤：
 创建Socket
 连接到服务器
 发送数据给服务器
 从服务器接收数据
 关闭连接
 导入头文件
 #import <sys/socket.h>
 #import <netinet/in.h>
 #import <arpa/inet.h>
 创建socket函数
 int socket(int domain, int type, int protocol);
 例子
 int clientSocket = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
 参数介绍
 协议域，又称协议族（family），协议族决定了socket的地址类型
 常用的有：
 AF_INET决定了要用ipv4地址（32位的）与端口号（16位的）的组合
 AF_INET6 ipv6
 AF_LOCAL或AF_UNIX决定了要用一个绝对路径名作为地址
 
 socket类型
 常用的socket类型有：
 SOCK_STREAM 流式Socket 针对于面向连接的TCP服务应用
 SOCK_DGRAM 数据报式Socket 对应于无连接的UDP服务应用
 
 指定协议，与类型对应，如果传入0会根据第二个参数选择合适的值
 常用协议有IPPROTO_TCP（TCP传输协议）、IPPROTO_UDP（UDP传输协议）
 
 返回值：
 如果调用成功就返回新创建的套接字的描述符（套接字描述符是一个整数类型的值），如果失败就返回-1
 
 connect连接到服务器
 作用：用来将参数sockfd 的socket 连至参数serv_addr 指定的网络地址
 
 int connect(int sockfd, const struct sockaddr * serv_addr, socklen_t addrlen);
 例子
 struct sockaddr_in addr;
 addr.sin_family = AF_INET;
 addr.sin_addr.s_addr = inet_addr("127.0.0.1");
 addr.sin_port = htons(12345);
 
 int result = connect(clientSocket, (const struct sockaddr *) &addr, sizeof(addr));
 if (result != 0) {
 NSLog(@"失败");
 return;
 }
 参数介绍
 套接字描述符
 指向结构体sockaddr_in的指针，其中包括目的端口和IP地址等
 struct sockaddr_in {
 __uint8_t sin_len;
 sa_family_t sin_family;  //类型：IPV4类型
 in_port_t sin_port;  //端口号，要使用大尾顺序（各个计算机CPU型号不同，存储的顺序也会不同，htons()函数会将各个计算机统一为网络需要的大尾顺序）
 struct in_addr sin_addr;  //IP地址，无符号长整型数字，调用结构体中s_addr，通过inet_addr()函数可以转换字符串
 char sin_zero[8];
 };
 参数二sockaddr的长度，可以通过sizeof（struct sockaddr）获得
 返回值：成功则返回0，失败返回非0，错误码GetLastError()。
 发送数据
 #include < sys/socket.h >
 作用
 用来将数据由指定的 socket 传给对方主机。使用 send 时套接字必须已经连接。send 不包含传送失败的提示信息，如果检测到本地错误将返回-1。因此，如果send 成功返回，并不必然表示连接另一端的进程接收数据。所保证的仅是当send 成功返回时，数据已经无错误地发送到网络上。
 
 ssize_t send(int s, const void * msg, size_t len, int flags);
 例子
 const char *msg = "hello world";
 ssize_t sendCount = send(clientSocket, msg, strlen(msg), 0);
 NSLog(@"发送的字节数 %zd",sendCount);
 参数介绍
 指定发送端套接字描述符
 指明一个存放应用程式要发送数据的缓冲区（要发送的数据）
 指明实际要发送的数据的字符个数，注意：是字符个数 strlen()，不能是字节数sizeof ( )
 是否阻塞，一般填0
 返回值：成功则返回实际传送出去的字符数，失败返回－1，错误原因存于errno 中。
 构造http请求头
 NSString *request = @"GET / HTTP/1.1\r\n"
 "Host: www.baidu.com\r\n"
 "Connection: keep-alive\r\n\r\n";
 http请求头中使用
 "Connection: keep-alive\r\n\r\n";长连接
 "Connection: keep-close\r\n\r\n";短连接
 //http/1.0 短连接 当响应结束后连接会立即断开
 //http/1.1 长连接 当响应结束后，连接会等待非常短的时间，如果这个时间内没有新的请求，就断开连接
 
 http长连接和短连接的区别与联系
 长连接 http 1.1 默认保持长连接，数据传输完成了保持TCP连接不断开，等待在同域名下继续用这个通道传输数据。Keep-alive，不一定能保证是长连接(服务器也能决定是否给你长连接)，长连接也有超时的时长！
 http长连接优点是响应快、传输更稳定，缺点是服务器开销大。
 短连接联完后，立即关闭
 http长连接和短连接的应用场景
 http长连接的应用场景：苹果推送服务器、网络游戏、静态网页
 http短连接的应用场景：动态网页（php等）
 接收服务器返回的数据
 ssize_t recv(int s, void * buf, size_t len, int flags);
 例子：
 //接收服务器返回的数据
 //返回的是实际接收的字节个数
 uint8_t buffer[1024];
 ssize_t recvCount = recv(clientSocket, buffer, sizeof(buffer), 0);
 NSLog(@"接收的字节数 %zd",recvCount);
 //把字节数组转换成字符串
 NSData *data = [NSData dataWithBytes:buffer length:recvCount];
 NSString *recvMsg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
 NSLog(@“收到的字符串 : %@",recvMsg);
 参数介绍：
 套接字描述符
 存放接收到的数据字节的数组，uint8_t类型
 可以通过NSData的dataWithBytes:方法将字节（Bytes）转换为Data数据
 存放字节的数组大小
 是否阻塞，一般填0
 返回值：
 若无错误发生，返回值为读入的字节数。如果连接已中止，返回0。否则的话，返回SOCKET_ERROR错误，应用程序可通过WSAGetLastError()获取相应错误代码。
 截取响应体：
 http响应头的特点，发现http请求头最后结尾的位置，发现最后是"\r\n\r\n"结尾的，那我们只需要找到"\r\n\r\n"的位置，然后截取收到的http返回的数据！最后将数据给webView就行！
 
 //找到\r\n\r\n 的范围
 NSRange range = [respose rangeOfString:@"\r\n\r\n"];
 //从\r\n\r\n之后的第一个位置开始截取字符串  响应体
 NSString *html = [respose substringFromIndex:range.length + range.location ];
 关闭连接
 int close(int s);
 s 套接字描述符
 
 例子：请求百度
 //发送和接收数据
 - (NSString *)sendAndRecv:(NSString *)sendMsg {
 //3 向服务器发送数据
 //成功则返回实际传送出去的字符数，失败返回－1
 const char *msg = sendMsg.UTF8String;
 ssize_t sendCount = send(self.clientSocket, msg, strlen(msg), 0);
 NSLog(@"发送的字节数 %zd",sendCount);
 //4 接收服务器返回的数据
 //返回的是实际接收的字节个数
 uint8_t buffer[1024];
 NSMutableData *mData = [NSMutableData data];
 ssize_t recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);;
 [mData appendBytes:buffer length:recvCount];
 //服务器会返回多次数据，等所有的数据都接收完成，再转换成字符串
 while (recvCount != 0) {
 recvCount = recv(self.clientSocket, buffer, sizeof(buffer), 0);
 NSLog(@"接收的字节数 %zd",recvCount);
 [mData appendBytes:buffer length:recvCount];
 }
 //把字节数组转换成字符串
 NSString *recvMsg = [[NSString alloc] initWithData:mData.copy encoding:NSUTF8StringEncoding];
 return recvMsg;
 }
 
 */
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

