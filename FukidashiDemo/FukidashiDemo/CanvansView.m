//
//  CanvansView.m
//  FukidashiDemo
//
//  Created by zdc on 2016/09/29.
//  Copyright © 2016年 zdc. All rights reserved.
//

#import "CanvansView.h"
@interface CanvansView()
{
    float right_top_endge_angle;
    float left_top_endge_angle;
    BOOL isWidthRightEdge;
    BOOL isWidthLeftEdge;
}
@end

@implementation CanvansView

-(instancetype)init {
    self = [super init];
    if (self) {
        self.angle = -M_PI_2;
        self.width = 80;
        self.height = 40;
        self.arrowHeight = 65;
    }
    
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 2);
    
    CGContextSetRGBStrokeColor(ctx, 1, 1, 0, 1.0);
    CGContextAddRect(ctx, CGRectMake(CGRectGetMidX(rect)-self.arrowHeight, CGRectGetMidY(rect)-self.arrowHeight, self.arrowHeight*2, self.arrowHeight*2));
    CGContextDrawPath(ctx, kCGPathStroke);
    
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1.0);
    CGContextAddRect(ctx, CGRectMake(CGRectGetMidX(rect)-self.arrowHeight, CGRectGetMidY(rect)-self.arrowHeight, self.arrowHeight*2, self.arrowHeight*2));
    CGContextDrawPath(ctx, kCGPathFill);
    
    CGContextSetLineWidth(ctx, 1);
    CGContextAddRect(ctx, CGRectMake(CGRectGetMidX(rect)-self.arrowHeight-1, CGRectGetMidY(rect)-self.arrowHeight-1, self.arrowHeight*2+2, self.arrowHeight*2+2));
    CGContextDrawPath(ctx, kCGPathStroke);
    
    
    //////////////// - basic - ////////////
    //
    //   ② *----------------------* ③
    //      |                      |
    //   ① *--------*    *--------* ④
    //            ⑦ /  / ⑤
    //               /
    //              *  ⑥
    //////////////////////////////////////
    
    float base_x = CGRectGetMidX(rect);
    float base_y = CGRectGetMidY(rect);
    
    CGFloat radius = 5;
    
    int dist_x = -1;
    int dist_y = 1;
    if (self.angle < -M_PI) {
        self.angle += M_PI*2;
    }
    
    if (self.angle > M_PI) {
        self.angle -= M_PI *2;
    }
    
    if(self.angle >= 0 && self.angle <= M_PI) {
        dist_x = 1;
    }
    
    if (self.angle > -M_PI_2 && self.angle < M_PI_2) {
        dist_y = -1;
    }
    
    float maxWidthOffset = self.arrowHeight + self.width *0.5;
    float maxHeightOffset = self.arrowHeight + self.height *0.5;
    
    CGPoint center = CGPointMake(base_x + dist_x * maxWidthOffset/ tan(self.angle), base_y - dist_y * maxHeightOffset * tan(self.angle));
    
    
    if(center.x >= base_x + maxWidthOffset) {
        center.x = base_x + maxWidthOffset;
    }else if (center.x <= base_x - maxWidthOffset) {
        center.x = base_x - maxWidthOffset;
    }
    
    if(center.y >= base_y + maxHeightOffset) {
        center.y = base_y + maxHeightOffset;
    }else if (center.y <= base_y - maxHeightOffset) {
        center.y = base_y - maxHeightOffset;
    }
    
    CGPoint foot_1 =  CGPointZero;
    CGPoint foot_2 =  CGPointZero;
    CGPoint foot_3 =  CGPointMake(base_x, base_y);
    
    if((_angle > -M_PI_2 && _angle <= 0) || _angle > M_PI_2) {
        // sin 为负值，cos 为正值
        foot_1 = CGPointMake(center.x + (-1)* sin(_angle)*10, center.y + cos(_angle)*10);
        foot_2 = CGPointMake(center.x - (-1) *sin(_angle)*10, center.y - cos(_angle)*10);
    }else{
        foot_1 = CGPointMake(center.x + sin(_angle)*10, center.y + (-1) *cos(_angle)*10);
        foot_2 = CGPointMake(center.x - sin(_angle)*10, center.y - (-1) *cos(_angle)*10);
    }
    
    
    CGPoint left_top = CGPointZero;
    CGPoint right_top = CGPointZero;
    CGPoint right_bottom = CGPointZero;
    CGPoint left_bottom = CGPointZero;
    
    left_top = CGPointMake(center.x - self.width * 0.5 + radius, center.y - self.height*0.5 + radius);
    right_top = CGPointMake(center.x + self.width *0.5 - radius, center.y - self.height*0.5 + radius);
    right_bottom = CGPointMake(center.x + self.width *0.5 - radius, center.y + self.height*0.5 - radius);
    left_bottom = CGPointMake(center.x - self.width *0.5 + radius, center.y + self.height*0.5 - radius);
    

    CGContextSetRGBStrokeColor(ctx, 0.024, 0.071, 0.282, 1.0);
    CGContextSetLineWidth(ctx, 4.0);
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:0.024 green:0.071 blue:0.282 alpha:1].CGColor);
    // 5
    CGContextMoveToPoint(ctx, foot_2.x, foot_2.y);
    // 6
    CGContextAddLineToPoint(ctx, foot_3.x, foot_3.y);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // 7
    CGContextMoveToPoint(ctx, foot_1.x, foot_1.y);
    // 6
    CGContextAddLineToPoint(ctx, foot_3.x, foot_3.y);
    CGContextDrawPath(ctx, kCGPathStroke);
    
    // color = #061248
    CGContextSetRGBStrokeColor(ctx, 0.024, 0.071, 0.282, 1.0);
    // #1244d6 (R:18 G:68 B:214)
    UIColor *aColor = [UIColor colorWithRed:0.071 green:0.267 blue:0.839 alpha:1];
    CGContextSetFillColorWithColor(ctx, aColor.CGColor);
    // set pan width
    CGContextSetLineWidth(ctx, 2.0);
    
    // 2
    CGContextAddArc(ctx, left_top.x, left_top.y, radius, M_PI, 3 * M_PI / 2, 0);
    // 3
    CGContextAddArc(ctx, right_top.x, right_top.y, radius, 3 * M_PI / 2, 0, 0);
    // 4
    CGContextAddArc(ctx, right_bottom.x, right_bottom.y, radius, 0, M_PI_2, 0);
    // 1
    CGContextAddArc(ctx, left_bottom.x, left_bottom.y, radius, M_PI_2, M_PI, 0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    // 5
    CGContextMoveToPoint(ctx, foot_2.x, foot_2.y);
    // 6
    CGContextAddLineToPoint(ctx, foot_3.x, foot_3.y);
    // 7
    CGContextAddLineToPoint(ctx, foot_1.x, foot_1.y);
    CGContextDrawPath(ctx, kCGPathFill);
    
}


@end
