//
//  ViewController.m
//  Core Animation
//
//  Created by Matthew Newberry on 5/10/13.
//  Copyright (c) 2013 Newberry. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

#define kLayerName   @"Layer"

@interface ViewController ()

@property (nonatomic, strong) NSMutableArray *layers;
@property (nonatomic, strong) UIImageView *bitmapView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.layers = [NSMutableArray array];
    self.bitmapView = [[UIImageView alloc] init];
    
    [self redraw:nil];
}

- (IBAction)redraw:(id)sender
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    NSArray *sublayers = [NSArray arrayWithArray:_layers];
    for(CALayer *l in sublayers) {
        if([l.name isEqualToString:kLayerName]) {
            [l removeFromSuperlayer];
        }
    }
    
    [_layers removeAllObjects];
    [CATransaction commit];
    
    if(_panelShadow.on) {
        _leftView.layer.shadowOpacity = 0.75;
        _leftView.layer.shadowOffset = CGSizeMake(2.f, 0);
        
        if(_panelShadowPath.on) {
            _leftView.layer.shadowPath = [UIBezierPath bezierPathWithRect:_leftView.bounds].CGPath;
        }
    } else {
        _leftView.layer.shadowOpacity = 0.f;
    }
    
    int num = [_numberOfElements.text intValue];
    float padding = 5.f;
    
    int layerSize = [_elementSize.text intValue];
    CGSize size = CGSizeMake(layerSize, layerSize);
    
    float runningWidth = 0;
    float runningHeight = 0;
    
    for(int x = 0; x <= num; x++) {
        
        CALayer *layer = [CALayer layer];
        
        if(_caShapeLayer.on) {
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            layer = shapeLayer;
            shapeLayer.path = [self logoPath].CGPath;
            shapeLayer.fillColor = [UIColor blueColor].CGColor;
        } else if(_caGradientLayer.on) {
            CAGradientLayer *gradientLayer = [CAGradientLayer layer];
            layer = gradientLayer;
            gradientLayer.colors = @[(id)[UIColor whiteColor].CGColor, (id)[UIColor blueColor].CGColor];
        } else {
            layer.backgroundColor = [UIColor blueColor].CGColor;
        }
        
        if(_roundedCorners.on) {
            layer.cornerRadius = 10.f;
        }
        
        layer.name = kLayerName;
        layer.frame = CGRectMake(runningWidth, runningHeight, size.width, size.height);
        
        if(_shadow.on) {
            layer.shadowOpacity = 0.5f;
            
            if(_shadowPath.on) {
                layer.shadowPath = [UIBezierPath bezierPathWithRect:layer.bounds].CGPath;
            }
        } else {
            _shadowPath.on = NO;
        }
        
        [_scrollView.layer addSublayer:layer];
        
        runningWidth += size.width + padding;
        
        if(runningWidth > _scrollView.frame.size.width) {
            runningWidth = 0;
            runningHeight += size.height + padding;
        }
        
        [_layers addObject:layer];
    }
    
     _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, runningHeight);
    
    _bitmapView.image = nil;
    
    if(_bitmap.on) {
        UIGraphicsBeginImageContextWithOptions(_scrollView.contentSize, YES, [UIScreen mainScreen].scale);
        
        CGRect cachedFrame = _scrollView.frame;
        _scrollView.frame = CGRectMake(0, 0, _scrollView.contentSize.width, _scrollView.contentSize.height);
        [_scrollView.layer renderInContext:UIGraphicsGetCurrentContext()];
        _scrollView.frame = cachedFrame;
        
        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        _bitmapView.image = image;
        [_bitmapView sizeToFit];
        
        if(![_bitmapView superview]) {
            [_scrollView addSubview:_bitmapView];
        }
    }
    
    [self.view bringSubviewToFront:_leftView];
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self redraw:textField];
    return YES;
}

- (UIBezierPath *)logoPath
{
    static UIBezierPath* bezierPath;
    
    if(!bezierPath) {
        bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint: CGPointMake(36.29, 31.01)];
        [bezierPath addCurveToPoint: CGPointMake(33.77, 33.53) controlPoint1: CGPointMake(36.29, 32.4) controlPoint2: CGPointMake(35.16, 33.53)];
        [bezierPath addLineToPoint: CGPointMake(13.75, 33.53)];
        [bezierPath addLineToPoint: CGPointMake(13.75, 31.05)];
        [bezierPath addCurveToPoint: CGPointMake(16.27, 28.53) controlPoint1: CGPointMake(13.75, 29.66) controlPoint2: CGPointMake(14.88, 28.53)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 28.53)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 31.01)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(13.71, 15.7)];
        [bezierPath addLineToPoint: CGPointMake(13.71, 13.22)];
        [bezierPath addCurveToPoint: CGPointMake(16.23, 10.7) controlPoint1: CGPointMake(13.71, 11.83) controlPoint2: CGPointMake(14.84, 10.7)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 10.7)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 13.18)];
        [bezierPath addCurveToPoint: CGPointMake(33.77, 15.7) controlPoint1: CGPointMake(36.29, 14.57) controlPoint2: CGPointMake(35.16, 15.7)];
        [bezierPath addLineToPoint: CGPointMake(13.71, 15.7)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(36.29, 21.94)];
        [bezierPath addCurveToPoint: CGPointMake(33.77, 24.45) controlPoint1: CGPointMake(36.29, 23.33) controlPoint2: CGPointMake(35.16, 24.45)];
        [bezierPath addLineToPoint: CGPointMake(13.75, 24.45)];
        [bezierPath addLineToPoint: CGPointMake(13.75, 22.29)];
        [bezierPath addCurveToPoint: CGPointMake(16.27, 19.77) controlPoint1: CGPointMake(13.75, 20.9) controlPoint2: CGPointMake(14.88, 19.77)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 19.77)];
        [bezierPath addLineToPoint: CGPointMake(36.29, 21.94)];
        [bezierPath closePath];
        [bezierPath moveToPoint: CGPointMake(42.91, 33.53)];
        [bezierPath addLineToPoint: CGPointMake(42.03, 33.53)];
        [bezierPath addLineToPoint: CGPointMake(42.03, 4.95)];
        [bezierPath addLineToPoint: CGPointMake(7.97, 4.95)];
        [bezierPath addLineToPoint: CGPointMake(7.97, 39.29)];
        [bezierPath addLineToPoint: CGPointMake(38.07, 39.29)];
        [bezierPath addCurveToPoint: CGPointMake(42.32, 43.36) controlPoint1: CGPointMake(40.32, 39.29) controlPoint2: CGPointMake(42.32, 41.11)];
        [bezierPath addLineToPoint: CGPointMake(42.32, 44.19)];
        [bezierPath addLineToPoint: CGPointMake(42.32, 50)];
        [bezierPath addLineToPoint: CGPointMake(36.33, 44.19)];
        [bezierPath addLineToPoint: CGPointMake(7.86, 44.19)];
        [bezierPath addLineToPoint: CGPointMake(7.09, 44.19)];
        [bezierPath addCurveToPoint: CGPointMake(3.02, 40.12) controlPoint1: CGPointMake(4.84, 44.19) controlPoint2: CGPointMake(3.02, 42.36)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 4.84)];
        [bezierPath addLineToPoint: CGPointMake(3.02, 4.07)];
        [bezierPath addCurveToPoint: CGPointMake(7.09, 0) controlPoint1: CGPointMake(3.02, 1.82) controlPoint2: CGPointMake(4.84, 0)];
        [bezierPath addLineToPoint: CGPointMake(42.14, 0)];
        [bezierPath addLineToPoint: CGPointMake(42.91, 0)];
        [bezierPath addCurveToPoint: CGPointMake(46.98, 4.07) controlPoint1: CGPointMake(45.16, 0) controlPoint2: CGPointMake(46.98, 1.82)];
        [bezierPath addLineToPoint: CGPointMake(46.98, 29.46)];
        [bezierPath addCurveToPoint: CGPointMake(42.91, 33.53) controlPoint1: CGPointMake(46.98, 31.7) controlPoint2: CGPointMake(45.16, 33.53)];
        [bezierPath closePath];
        bezierPath.miterLimit = 4;
        
        bezierPath.usesEvenOddFillRule = YES;
        
        [[UIColor blackColor] setFill];
        [bezierPath fill];
    }
    
    return bezierPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
