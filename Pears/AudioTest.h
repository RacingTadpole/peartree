//
//  AudioTest.h
//  Pears
//
//  Created by Arthur Street on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import <AVFoundation/AVFoundation.h>

#import <OpenAL/al.h>
#import <OpenAL/alc.h>


@interface AudioTest : NSObject {
    ALuint					source;
	ALuint					buffer;
	ALCcontext*				context;
	ALCdevice*				device;
    void*					data;
}

@property (nonatomic) float x,y,z;

- (void)startSound;
- (void)stopSound;


@end
