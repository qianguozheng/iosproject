//
//  DrawLine.m
//  DrawLine
//
//  Created by weeds on 14-10-20.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import "DrawLine.h"

@implementation DrawLine

- (id)initWithFrame:(CGRect)frame
{
    NSLog(@" %s", __func__);
    self = [super initWithFrame:frame];
    if (self) {
        self.lineArray = [NSMutableArray arrayWithCapacity:1];
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        button.frame = CGRectMake((frame.size.width - 100)/2, frame.size.height - 50, 100, 30);
        [button setTitle:@"undo" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(undo:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor greenColor];
        [self addSubview:button];
        
    }
    return self;
}

-(void) undo:(UIButton *)button
{
     NSLog(@" %s: _lineArray=%@", __func__, [_lineArray objectAtIndex:([_lineArray count]-1)]);    //if ([_lineArray count] > 0) {
        [_lineArray removeLastObject];
    //}

    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    NSLog(@" %s", __func__);
    //得到上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //设置画笔的颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    //设置画笔粗细
    CGContextSetLineWidth(context, 2.0);
    
    for (int i=0; i<[_lineArray count]; i++) {
        NSMutableArray *pointArray = [_lineArray objectAtIndex:i];
        for (int j=0; j<(int)pointArray.count - 1; j++) {
            NSValue * firstPointValue = [pointArray objectAtIndex:j];
            NSValue * secondPointValue = [pointArray objectAtIndex:j+1];
            
            CGPoint firstPoint = [firstPointValue CGPointValue];
            CGPoint secondPoint = [secondPointValue CGPointValue];
            //把笔触移动一个点
            CGContextMoveToPoint(context, firstPoint.x, firstPoint.y);
            CGContextAddLineToPoint(context, secondPoint.x, secondPoint.y);
        }
    }
    //绘制
    CGContextStrokePath(context);
}


- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" %s", __func__);
    NSMutableArray * pointArray = [NSMutableArray arrayWithCapacity:1];
    [_lineArray addObject:pointArray];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@" %s", __func__);
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
    NSLog(@"point = %@", NSStringFromCGPoint(point));
    
    NSMutableArray *pointArray = [_lineArray lastObject];
    NSValue *pointValue = [NSValue valueWithCGPoint:point];
    [pointArray addObject:pointValue]; //addObject need (id)
    
    [self setNeedsDisplay];
}

@end
