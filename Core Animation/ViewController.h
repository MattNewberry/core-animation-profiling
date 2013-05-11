//
//  ViewController.h
//  Core Animation
//
//  Created by Matthew Newberry on 5/10/13.
//  Copyright (c) 2013 Newberry. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIView *leftView;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UITextField *numberOfElements;
@property (nonatomic, weak) IBOutlet UITextField *elementSize;

@property (nonatomic, weak) IBOutlet UISwitch *panelShadow;
@property (nonatomic, weak) IBOutlet UISwitch *panelShadowPath;
@property (nonatomic, weak) IBOutlet UISwitch *shadow;
@property (nonatomic, weak) IBOutlet UISwitch *shadowPath;

@property (nonatomic, weak) IBOutlet UISwitch *caShapeLayer;
@property (nonatomic, weak) IBOutlet UISwitch *caGradientLayer;

@property (nonatomic, weak) IBOutlet UISwitch *roundedCorners;

@property (nonatomic, weak) IBOutlet UISwitch *bitmap;

- (IBAction)redraw:(id)sender;

@end
