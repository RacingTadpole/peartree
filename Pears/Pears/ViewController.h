//
//  ViewController.h
//  Pears
//
//  Created by Arthur Street on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AudioTest.h"

@interface ViewController : UIViewController
- (IBAction)sliderX:(UISlider *)sender;
- (IBAction)sliderY:(UISlider *)sender;
- (IBAction)sliderZ:(UISlider *)sender;
- (IBAction)goButton:(UIButton *)sender;
- (IBAction)musicButton:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet AudioTest *audioModel;
@property (weak, nonatomic) IBOutlet UISlider *sliderX;
@property (weak, nonatomic) IBOutlet UISlider *sliderY;
@property (weak, nonatomic) IBOutlet UISlider *sliderZ;

@end
