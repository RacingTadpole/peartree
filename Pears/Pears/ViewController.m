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

@end

@implementation ViewController

@synthesize audioModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"View loaded");
}

- (void)viewDidUnload
{
    [self setAudioModel:nil];
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
}

- (IBAction)sliderY:(UISlider *)sender {
}

- (IBAction)sliderZ:(UISlider *)sender {
}

- (IBAction)goButton:(UIButton *)sender {
    [audioModel startSound];
}

@end
