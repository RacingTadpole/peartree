//
//  ViewController.m
//  Pears
//
//  Created by Arthur Street on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AudioTest.h"

@interface ViewController ()
@property BOOL playing;
@end

@implementation ViewController

@synthesize audioModel;
@synthesize sliderX;
@synthesize sliderY;
@synthesize sliderZ;
@synthesize playing;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    playing = NO;
    sliderX.value = audioModel.x;
    sliderY.value = audioModel.y;
    sliderZ.value = audioModel.z;
    NSLog(@"View loaded");
}

- (void)viewDidUnload
{
    [self setAudioModel:nil];
    [self setSliderX:nil];
    [self setSliderY:nil];
    [self setSliderZ:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (IBAction)sliderX:(UISlider *)sender {
    [audioModel setX:sender.value];
}

- (IBAction)sliderY:(UISlider *)sender {
    [audioModel setY:sender.value];
}

- (IBAction)sliderZ:(UISlider *)sender {
    [audioModel setZ:sender.value];
}

- (IBAction)goButton:(UIButton *)sender {
    if (!playing) {
        [audioModel startSound];
    } else {
        [audioModel stopSound];
    }
    playing = !playing;
}

- (IBAction)musicButton:(UIButton *)sender {
}

@end
