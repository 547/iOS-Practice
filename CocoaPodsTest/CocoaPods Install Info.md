
**原文**
  [http://www.cnblogs.com/zxs-19920314/p/4985476.html](CocoaPods%20%E5%AE%89%E8%A3%85%E6%95%99%E7%A8%8B)

 -   1.移除现有Ruby默认源 $gem sources --remove https://rubygems.org/

 

 -  2.使用新的源 $gem sources -a https://ruby.taobao.org/
 -  3.验证新源是否替换成功 $gem sources -l

 

 -  4.安装CocoaPods
>   (1) $sudo gem install cocoapods 备注：苹果系统升级 OS X EL Capitan 后改为 $sudo gem install -n /usr/local/bin cocoapods 
>  -(2) $pod setup
> 
 

 - 5.更新gem $sudo gem update --system
 - 6新建工程，并在终端用cd指令到文件夹内 $pod search 第三方

 

 - 7.新建文件 vim “Podfile”， $vim Podfile 写入以下内容并保存 小提示：（终端vim文件 按 i 可编辑 ，esc 退出编辑，：wq  可保存退出） platform:ios, '6.0'   （这句话可以不写） pod      
   'AFNetworking', '~> 2.3.1'    <-------第三方
   （这两句文字的意思是，当前AFNetworking支持的iOS最高版本是iOS 6.0,
   要下载的AFNetworking版本是2.3.1。）

 - 8.导入第三方库 $pod install
  

 - 9.退出终端 以下是我用以前的安装流程安装时出现的一些错误

 

 - 10.打开项目：注意：现在打开项目不是点击 PodTest.xodeproj了，而是点击 PodTest.xcworkspace

**终端  cocoapods 下载bug调试：**

> 错误1： Error fetching http://ruby.taobao.org/: bad response Not Found
> 404 (http://ruby.taobao.org/specs.4.8.gz) 
> 解决方案：把安装流程中 $gem sources -a
> http://ruby.taobao.org/   ---改为----> $gem sources -a
> https://ruby.taobao.org/
> 


----------


> 错误2： ERROR:  While executing gem ... (Errno::EPERM) Operation not
解决方案：苹果系统升级OS X EL Capitan后会出现的插件错误，将安装流程
> 4.安装CocoaPods 的 (1)sudo gem install cocoapods ——>改为sudo gem install -n /usr/local/bin cocoapods
> 


----------


> 错误3： [!] Unable to satisfy the following requirements: - `AVOSCloud
> (~> 3.1.6.3)` required by `Podfile` Specs satisfying the `AVOSCloud
> (~> 3.1.6.3)` dependency were found, but they required a higher
> minimum deployment target. 
> 解决方案：安装流程：Podfile文件 中   platform:ios, ‘6.0’
> 后边的 6.0 是平台版本号 ，一定要加上



**> CocoaPods中的头文件import导入时不能自动补齐的解决方法**
> 
> 具体来说就是: 选择工程的 Target -> Build Settings 菜单，找到\”User Header Search
> Paths\”设置项 新增一个值"$(PODS_ROOT)"，并且选择\”recursive\”，这样xcode就会在项目目录中递归搜索文件
> 自动补齐功能马上就好使了。
