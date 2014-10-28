//
//  XYZTouchView.m
//  TouchEvent
//
//  Created by weeds on 14-10-19.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import "XYZTouchView.h"

@implementation XYZTouchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    //self.userInteractionEnabled = NO;
    self.multipleTouchEnabled = YES;
    return self;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesBegan");
    self.backgroundColor =[UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1.0];
// 点击移动UIView
//    UITouch * touch = [touches anyObject];
//    NSInteger num = [touches count];
//    
//    _startPoint = [touch locationInView:self];
//    
//    NSLog(@"point=%@, touch count=%u", NSStringFromCGPoint(_startPoint), num);
    NSInteger num = [touches count];
    NSArray *array = [touches allObjects];
    
    UITouch *touch0 = [array objectAtIndex:0];
    UITouch *touch1 = [array objectAtIndex:1];
    
    CGPoint point0 = [touch0 locationInView:self];
    CGPoint point1 = [touch1 locationInView:self];
    
    previousDistance = sqrt(pow(point0.x - point1.x, 2.0f) +
                            pow(point0.y - point1.y, 2.0f));
    NSLog(@"point0=%@, point1=%@, touch count=%u", NSStringFromCGPoint(point0), NSStringFromCGPoint(point1),num);
    previousFrame = self.frame.size;
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesMoved");
// 点击移动UIView
//    UITouch * touch = [touches anyObject];
//    CGPoint currentPoint = [touch locationInView:self];
//    CGFloat offsetX = currentPoint.x - _startPoint.x;
//    CGFloat offsetY = currentPoint.y - _startPoint.y;
//    NSLog(@"offsetx =%f, offsety = %f", offsetX, offsetY);
//    
//    CGPoint newCenter = self.center;
//    newCenter.x = newCenter.x + offsetX;
//    newCenter.y = newCenter.y + offsetY;
//    
//    self.center = newCenter;
//    NSLog(@"currentPoint=%@", NSStringFromCGPoint(currentPoint));
    if (event.allTouches.count == 2) {
        NSArray *array = [touches allObjects];
        CGPoint pointOne = [[array objectAtIndex:0] locationInView:self];
        CGPoint pointTwo = [[array objectAtIndex:1] locationInView:self];
        CGFloat distance = sqrt(pow(pointOne.x - pointTwo.x, 2.0f) +
                                pow(pointOne.y - pointTwo.y, 2.0f));
        zoomFactor += (distance - previousDistance) / previousDistance;
        zoomFactor = fabs(zoomFactor);
        
        previousDistance = distance;
        NSLog(@"distance = %f", zoomFactor);
        
        //CGPoint center = self.center;
        //
        
        //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 320/(zoomFactor), 480/zoomFactor);
        self.transform = CGAffineTransformMakeScale(0.9, 0.9);
    }
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesEnded");
}
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchesCancelled");
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
