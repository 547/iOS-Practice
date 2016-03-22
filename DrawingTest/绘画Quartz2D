**绘画Quartz2D>>>>主要可以用于绘制K线图,比例图,树状图，做画画工具**



> **注意：** Quartz 2D：实际开发的过程中尽量不要使用以上这些方法来绘制内容和图片，因为用其绘制的内容和图片很耗费资源，UIlabel、UIimageView、 CAlayer都是底层做了最好的优化和处理使用它们就可以了。
> 


----------


> 主要利用ui控件的drawRect方法  添加对应的内容==就是重写drawRect方法

    //绘制控件的时候调用
    //PS:这个方法系统会自动调用，不要自己手动调用，如果实在需要用到这个方法的话可以通过[self setNeedsDisplay];帮助我们调用drawRect这个方法
        - (void)drawRect:(CGRect)rect {
            
            //1.创建画布
            CGContextRef context=UIGraphicsGetCurrentContext();
            //2.设置画笔颜色==边框
            CGContextSetStrokeColorWithColor(context, [UIColor blueColor].CGColor);
            //设置填充颜色==内部
            CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
            //3.设置画笔宽度
            CGContextSetLineWidth(context, 3.0f);
            //4.绘制形状===绘制的内容
            CGContextAddRect(context, CGRectMake(50, 50, 200, 200));
            //Ellipse==椭圆
            //绘制圆
            CGContextAddEllipseInRect(context, CGRectMake(200, 200, 300, 300));
            //绘制椭圆
            CGContextAddEllipseInRect(context, CGRectMake(100, 260, 200, 300));
        
            //设置线段的起点
            CGContextMoveToPoint(context, 10, 100);
            //添加线段：线段的起始点如果不设置就默认为上一次画笔结束的点
            CGContextAddLineToPoint(context, 20, 200);
            /*
             绘制弧线:
             第2，3，4个参数是中心点x，y以及半径
             第5，6个参数是开始角度 结束角度
             第7个参数 顺逆时针（1顺时针，0逆时针）
            */
            CGContextAddArc(context, 200, 200, 50, M_PI, 1.5*M_PI, 1);
           
            //5.绘制
            //PS:下面两个方法不可以一起调用不然就只会是用边框绘图
        //    CGContextStrokePath(context);//用边框颜色绘图
            CGContextFillPath(context);//用填充颜色绘图
            
            //PS:绘制字体要写在 CGContextStrokePath(context); CGContextFillPath(context);下面，不然就会默认为黑色
            //绘制字体
            [@"绘制字体" drawAtPoint:CGPointMake(100, 500) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
            
            //获取图片
            UIImage *img=[UIImage imageNamed:@"1.png"];
            //旋转、平移、缩放（起始点变了，左下角是0，0）
             /*
     缩放操作根据指定的x, y因子来改变坐标空间的大小，从而放大或缩小图像。x, y因子的大小决定了新的坐标空间是否比原始坐标空间大或者小。另外，通过指定x因子为负数，可以倒转x轴，同样可以指定y因子为负数来倒转y轴。通过调用CGContextScaleCTM函数来指定x, y缩放因子。图5-5显示了指定x因子为0.5，y因子为0.75后的缩放效果。
     
     */
            CGContextScaleCTM(context, 0.5, 0.5);//缩放
            /*
     旋转变换根据指定的角度来移动坐标空间。我们调用CGContextRotateCTM函数来指定旋转角度(以弧度为单位)
     */
            CGContextRotateCTM(context, M_PI*0.2);//旋转
 /*
     平移变换根据我们指定的x, y轴的值移动坐标系统的原点。我们通过调用CGContextTranslateCTM函数来修改每个点的x, y坐标值
     */
  
//    CGContextTranslateCTM (context, 100, 50);  //平移

            //绘制图片
            CGContextDrawImage(context, CGRectMake(200, 200, 100, 100), img.CGImage);
        }

