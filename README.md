# Quartz2DDemo

一、画线drawLine
1.获取上下文件UIGraphicsGetCurrentContext();
2.设置起点CGContextMoveToPoint(ctx, 10, 10);
3.添加连接点AddLineToPoint(ctx, 110, 10);
4.渲染CGContextStrokePath(ctx);
5.设置线宽CGContextSetLineWidth(ctx, 3);
6.设置线的颜色CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);//红色
7.再添加1个连接点完成矩形绘制
8.设置线的首尾样式CGContextSetLineCap(ctx, kCGLineCapButt);
9.设置线的连接样式CGContextSetLineJoin(ctx, kCGLineJoinRound);

二、画矩形drawRectangle
1.获取上下文件UIGraphicsGetCurrentContext();
2.设置起点,并连接四个点成为矩形
*CGContextMoveToPoint(ctx, 10, 10)
*AddLineToPoint(ctx, 110, 10);
*AddLineToPoint(ctx, 110, 110);
*AddLineToPoint(ctx, 110, 10);
*AddLineToPoint(ctx, 10, 10);
3.画空心CGContextStrokePath(ctx)
4.画实心CGContextFillPath(ctx);

5.使用CGContextStrokeRect();/ CGContextFillRect(); 画矩形


三、画三角形triangle
1.获取上下文件UIGraphicsGetCurrentContext();
2.设置起点,并连接三个点
3.关闭路径CGContextClosePath(ctx);
4.渲染CGContextStrokePath(ctx)


四、画圆circle
CGContextAddEllipseInRect(context, CGRectMake(10, 10, 100, 100));



五、画弧arc
//x y 圆点
//radius 半径
//startAngle 开始角度
//endAngle 结束角度
//clockwise 圆弧的伸展方向 0 顺时针 1 逆时针
CGContextAddArc(context, 100, 100, 50, 0, M_PI_2, 1);
//1顺时针 0


六、画扇形sector
//设置扇形路径的起点
CGContextMoveToPoint(context, 100, 100);
CGContextAddArc(context, 100, 100, 50, M_PI_4, 3 * M_PI_4, 0);
CGContextClosePath(context);

七、画文字和图片
调用文字的drawAtPoint:或drawInRect方法
文字可设置属性
@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};

图片
可view上画图片调用drawAtPoint:或drawInRect方法
drawAsPatternInRect可以平铺图片


八、画进度圈
/**
 目标：
 自定View的drawRect方法会在view显示的时候调用一次
 如果有重绘，需要调用view的setNeedsDisplay方法，就会调用drawRect方法，进行重绘
 */
"[画弧进度]步骤"
1.自定义一个ProgressCirle的view
2.在storyboard的箭头所指的控制器添加一个View,并将classes指向ProgressCirle
3.在自定义view里添加一个float 类型的progress属性
4.在ProgressCirle的drawRect方法中画文字和进度
//画文字
(1)根据progress格式化要显示的文本//eg.30%
(2)先使用NSString的【boundingRectWithSize:options:attributes:context:】计算文字的尺寸
(3)再计算文字显示的x\y值
(4)调用NSString的drawInRect 画文字

//画弧
(5)计算要画弧的位置 2π *progress
(6)调用CGContextAddArc(ctx, x, y,radius, startAngle, endAngle,clockwise)画弧
起始位置为0
(7)然后再设置起始位置为-45度，重新计算结束位置

5.在控制器的view中，设置ProgressCirle的进度为0.5

6.添加一个UISlider到控制器view,并设置UISlider的最大值为1

7.监听UISlider的事件，并改变ProgressCirle的progress属性

8.重写ProgressCirle的setProgress方法，并调用[self setNeedsDisplay]实现重绘


九、饼状图
/**目标
 *掌握饼状图的绘制原理
 */

步骤:
1.自定义一个饼状View(PieView),添加到控制器View上
2.添加PieView的一个类型为数据的sections属性，存储所有分类的个数，并添加一个颜色数组，用于存储颜色
3.在drawRect方法中遍历sections的大小
4.遍历sections中的个数，进行总数绘总
5.定义一个 "扇形的起始位置"
6.设置路径中心点
7.遍历sections，计算数组中每一个元素占用总数的比例
8.根据比例计算饼状的结束位置，并设置 "弧" 路径
9.渲染扇形在UIView上，实现实心的扇形
8.给 "扇形的起始位置" 重新赋值，进入下一个循环


十、图形上下文栈
"什么是图形上下文栈？"
(1)将当前的图形上下文状态copy一份到栈，这就是 '图形上下文栈'
(2)上下文的什么状态呢?比如 颜色、线宽，这些都是上下文的状态

"图形上下文栈有什么用？"
(1)恢复最初的绘图状态

"图形上下文栈API"
1.保存图形上下文状态使用CGContextSaveGState方法
2.恢复图形上下文状态使用CGContextRestoreGState方法
3.CGContextRestoreGState不能调用多次，要看图形上下文栈有多少个上下文状态可恢复


十、矩阵操作
/*目标
 *掌握在图层上下文中的平稳、缩放、旋转
 */
//平移
CGContextTranslateCTM(ctx, 0, -80);
//缩放 - xy方向缩放到原来的几倍
CGContextScaleCTM(ctx, 1.0, 1.0);
//旋转 沿左上角旋转
CGContextRotateCTM(ctx,-M_PI * 0.1);

十一、裁剪圆形图片
/*掌握CGContextClip方法的作用,这个方法是裁剪 "路径" 之外多余的部分*/

"裁剪圆形图片"步骤
1.自定义一个CircleImageView控件，在drawRect中，获取上下文，往上下文中添加一个圆的路径
2.调用CGContextClip的方法，裁剪路径之外多余的部分
3.自定义的控制中，添加一个imageName属性，然后回到drawrect方法画图
4.画圆的边框，使用CGContextAddEllipseInRect添加圆的路径，并使用CGContextStrokePath画空心圆


