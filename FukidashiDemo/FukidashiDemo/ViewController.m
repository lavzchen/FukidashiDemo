//
//  ViewController.m
//  FukidashiDemo
//
//  Created by zdc on 2016/09/29.
//  Copyright © 2016年 zdc. All rights reserved.
//

#import "ViewController.h"
#import "CanvansView.h"

@interface ViewController ()
{
    CanvansView *fukidashiView;
}

@property (weak, nonatomic) IBOutlet CanvansView *canvansView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _canvansView.angle = - M_PI_2;
    _canvansView.arrowHeight = 30;
    _canvansView.width = 80;
    _canvansView.height = 40;
    [_canvansView setNeedsDisplay];
    
}

- (IBAction)angleChange:(id)sender {
    double angle = ((UIStepper *)sender).value;
    NSLog(@"current angle : %f", angle);
    _canvansView.angle = angle/180 * M_PI;
    [_canvansView setNeedsDisplay];
}
- (IBAction)widthChange:(id)sender {
    double value = ((UIStepper *)sender).value;
    _canvansView.width = value;
    
    [_canvansView setNeedsDisplay];
}
- (IBAction)heightChange:(id)sender {
    double value = ((UIStepper *)sender).value;
    _canvansView.height = value;
    
    [_canvansView setNeedsDisplay];
}
- (IBAction)arrowHeightChange:(id)sender {
    double value = ((UIStepper *)sender).value;
    _canvansView.arrowHeight = value;
    
    [_canvansView setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
