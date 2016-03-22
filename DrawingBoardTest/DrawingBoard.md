DrawingBoardTest
===================
**画画工具**
主要用到了 Quartz 2D和手势实现的。

#pragma mark==画图工具的核心主要在怎么绘制出不同起点的线段

 - 解决这个问题的办法就是创建线段模型line，将拖拽手势获得的点加入到线段模型的点数组points里面，然后在自定义的VIew里面遍历线段数组lines，再在每个线段对象里面遍历点数组points

   


----------


	  -(void)addPoints:(UIPanGestureRecognizer *)pa
    {
        
        if (pa.state==UIGestureRecognizerStateBegan)
        {
            if (shouldEraser) {
                line=[[SWLine alloc]initWithLineColor:[colors lastObject]];
            }else{
            line=[[SWLine alloc]initWithLineColor:colors[seg.selectedSegmentIndex]];
            }
            line.lineWidth=slider.value;
            //将线段对象加入到lines里面
            [view.lines addObject:line];
        }if (pa.state==UIGestureRecognizerStateChanged) {
        //拖拽手势获得的点加入到线段模型的点数组points里面
            CGPoint point =[pa locationInView:[pa.view superview]];
            [line.points addObject:[NSValue valueWithCGPoint:point]];//数组只能存id，不可以存结构体，所以讲point转化为value后再存进去
        }
        [view setNeedsDisplay];}


----------


    - (void)drawRect:(CGRect)rect {
        //创建画板
        CGContextRef context=UIGraphicsGetCurrentContext();
        
        //划线
       //遍历lines数组
        [self.lines enumerateObjectsUsingBlock:^(SWLine *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //设置画笔的颜色
             CGContextSetStrokeColorWithColor(context, [obj.lineColor  CGColor]);
            //设置画笔的粗细
            CGContextSetLineWidth(context, obj.lineWidth);
             //遍历line的点数组points
            [obj.points enumerateObjectsUsingBlock:^(NSValue   * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGPoint point=[obj CGPointValue];//value转化为point
                if (idx==0) {
                    CGContextMoveToPoint(context, point.x, point.y);//设置线段的期待你
                }
                CGContextAddLineToPoint(context, point.x, point.y);
            }];
            //绘制
            CGContextStrokePath(context);
    
        }];
    
    }

#pragma mark== 保存截屏图片到相册

    -(void)save
    {
        UIImage *image=[self screenShots];
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存到相册中
    }

#pragma mark==截屏

    -(UIImage *)screenShots
    {
        UIGraphicsBeginImageContext(self.view.frame.size);
        CGContextRef context=UIGraphicsGetCurrentContext();//创建一个画布
        [view.layer renderInContext:context];
        UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image;
    }
