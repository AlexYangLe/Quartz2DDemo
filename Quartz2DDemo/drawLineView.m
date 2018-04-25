//
//  drawLineView.m
//  Quartz2DDemo
//
//  Created by yanglele on 2018/4/25.
//  Copyright © 2018年 alexYang. All rights reserved.
//


#import "drawLineView.h"

@implementation drawLineView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    //设置起点
    CGContextMoveToPoint(ctx, 20, 20);
    
    CGContextAddLineToPoint(ctx, 150, 280);
    //设置终点
    CGContextAddLineToPoint(ctx, 200, 200);
    
    //设置线宽
    CGContextSetLineWidth(ctx, 5);
    //设置线颜色
    CGContextSetRGBFillColor(ctx, 1, 0, 0, 1);
    
    // 设置线的头尾的样式
    CGContextSetLineCap(ctx, kCGLineCapButt);
    
    // 设置连接点的样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    //渲染,画到view上
    CGContextStrokePath(ctx);
}


@end
