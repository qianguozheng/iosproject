//
//  XYZTouchView.h
//  TouchEvent
//
//  Created by weeds on 14-10-19.
//  Copyright (c) 2014年 weeds. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYZTouchView : UIView
{
    CGPoint _startPoint;
    //mutiTouch
    CGFloat previousDistance;
    CGFloat zoomFactor;
    CGSize previousFrame;
}
@end
