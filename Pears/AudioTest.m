//
//  AudioTest.m
//  Pears
//
//  Created by Arthur Street on 21/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AudioTest.h"
#import "MyOpenALSupport.h"


@interface AudioTest()

- (void)initOpenAL;
- (void)teardownOpenAL;

@end

@implementation AudioTest


- (id)init
{	
	if (self = [super init]) {
        /*
		// Start with our sound source slightly in front of the listener
		sourcePos = CGPointMake(0., -70.);
		
		// Put the listener in the center of the stage
		listenerPos = CGPointMake(0., 0.);
		
		// Listener looking straight ahead
		listenerRotation = 0.;
		
		// setup our audio session
		OSStatus result = AudioSessionInitialize(NULL, NULL, interruptionListener, self);
		if (result) NSLog(@"Error initializing audio session! %ld\n", result);
		else {
			// if there is other audio playing, we don't want to play the background music
			UInt32 size = sizeof(iPodIsPlaying);
			result = AudioSessionGetProperty(kAudioSessionProperty_OtherAudioIsPlaying, &size, &iPodIsPlaying);
			if (result) NSLog(@"Error getting other audio playing property! %ld", result);
            
			// if the iPod is playing, use the ambient category to mix with it
			// otherwise, use solo ambient to get the hardware for playing the app background track
			UInt32 category = (iPodIsPlaying) ? kAudioSessionCategory_AmbientSound : kAudioSessionCategory_SoloAmbientSound;
            
			result = AudioSessionSetProperty(kAudioSessionProperty_AudioCategory, sizeof(category), &category);
			if (result) NSLog(@"Error setting audio session category! %ld\n", result);
            
			result = AudioSessionAddPropertyListener(kAudioSessionProperty_AudioRouteChange, RouteChangeListener, self);
			if (result) NSLog(@"Couldn't add listener: %ld", result);
            
			result = AudioSessionSetActive(true);
			if (result) NSLog(@"Error setting audio session active! %ld\n", result);
		}
        
		bgURL = [[NSURL alloc] initFileURLWithPath: [[NSBundle mainBundle] pathForResource:@"background" ofType:@"m4a"]];
		bgPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:bgURL error:nil];	
        
		wasInterrupted = NO;
		*/
        x = 1.0;
        y = 1.0;
        z = 1.0;
        NSLog(@"Initialising audio model.");
		// Initialize our OpenAL environment
		//[self initOpenAL];
        NSLog(@"Complete.");
	}
	
	return self;
}


#pragma mark OpenAL

- (void) initBuffer
{
	ALenum  error = AL_NO_ERROR;
	ALenum  format;
	ALsizei size;
	ALsizei freq;
	
	NSBundle*				bundle = [NSBundle mainBundle];
	
	// get some audio data from a wave file
	CFURLRef fileURL = (__bridge CFURLRef)[NSURL fileURLWithPath:[bundle pathForResource:@"sound" ofType:@"caf"]];
	
	if (fileURL)
	{	
		data = MyGetOpenALAudioData(fileURL, &size, &format, &freq);
		CFRelease(fileURL);
		
		if((error = alGetError()) != AL_NO_ERROR) {
			NSLog(@"error loading sound: %x\n", error);
			exit(1);
		}
		
		// use the static buffer data API
		alBufferDataStaticProc(buffer, format, data, size, freq);
		
		if((error = alGetError()) != AL_NO_ERROR) {
			NSLog(@"error attaching audio to buffer: %x\n", error);
		}		
	}
	else
		NSLog(@"Could not find file!\n");
}

- (void) initSource
{
	ALenum error = AL_NO_ERROR;
	alGetError(); // Clear the error
    
	// Turn Looping ON
	alSourcei(source, AL_LOOPING, AL_TRUE);
	
	// Set Source Position
	float sourcePosAL[] = {x, y, z};
	alSourcefv(source, AL_POSITION, sourcePosAL);
	
	// Set Source Reference Distance
	alSourcef(source, AL_REFERENCE_DISTANCE, 1.0f);
	
	// attach OpenAL Buffer to OpenAL Source
	alSourcei(source, AL_BUFFER, buffer);
	
	if((error = alGetError()) != AL_NO_ERROR) {
		NSLog(@"Error attaching buffer to source: %x\n", error);
		exit(1);
	}	
}


- (void)initOpenAL
{
	ALenum			error;
	
	// Create a new OpenAL Device
	// Pass NULL to specify the system’s default output device
	device = alcOpenDevice(NULL);
    NSLog(@"Device %p",device);
	if (device != NULL)
	{
		// Create a new OpenAL Context
		// The new context will render to the OpenAL Device just created 
		context = alcCreateContext(device, 0);
		if (context != NULL)
		{
			// Make the new context the Current OpenAL Context
			alcMakeContextCurrent(context);
			
			// Create some OpenAL Buffer Objects
			alGenBuffers(1, &buffer);
			if((error = alGetError()) != AL_NO_ERROR) {
				NSLog(@"Error Generating Buffers: %x", error);
				exit(1);
			}
			
			// Create some OpenAL Source Objects
			alGenSources(1, &source);
			if(alGetError() != AL_NO_ERROR) 
			{
				NSLog(@"Error generating sources! %x\n", error);
				exit(1);
			}
			
		}
	}
	// clear any errors
	alGetError();
	
	[self initBuffer];	
	[self initSource];
}

- (void)teardownOpenAL
{	
	// Delete the Sources
    alDeleteSources(1, &source);
	// Delete the Buffers
    alDeleteBuffers(1, &buffer);
	
    //Release context
    alcDestroyContext(context);
    //Close device
    alcCloseDevice(device);
}

#pragma mark Play / Pause

- (void)startSound
{
	ALenum error;
	
	NSLog(@"Start!\n");
	// Begin playing our source file
	alSourcePlay(source);
	if((error = alGetError()) != AL_NO_ERROR) {
		NSLog(@"error starting source: %x\n", error);
	} else {
		// Mark our state as playing (the view looks at this)
		//self.isPlaying = YES;
	}
}

- (void)stopSound
{
	ALenum error;
	
	NSLog(@"Stop!!\n");
	// Stop playing our source file
	alSourceStop(source);
	if((error = alGetError()) != AL_NO_ERROR) {
		NSLog(@"error stopping source: %x\n", error);
	} else {
		// Mark our state as not playing (the view looks at this)
		//self.isPlaying = NO;
	}
}


@end
