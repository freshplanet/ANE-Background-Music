//
//  AirBackgroundMusic.m
//  AirBackgroundMusic
//
//  Created by Thibaut Crenn on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AirBackgroundMusic.h"
#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])


@implementation AirBackgroundMusic

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

@end

DEFINE_ANE_FUNCTION(initAudio)
{
    // silence everything.
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    NSString* category =  [[AVAudioSession sharedInstance] category];
    
    const char *str = [category UTF8String];
    
    // Prepare for AS3
    FREObject retStr;
	FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &retStr);
    return retStr;
}

// ContextInitializer()
//
// The context initializer is called when the runtime creates the extension context instance.
void AirBgMusicContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
                                 uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) 
{    
    // Register the links btwn AS3 and ObjC. (dont forget to modify the nbFuntionsToLink integer if you are adding/removing functions)
    NSInteger nbFuntionsToLink = 1;
    *numFunctionsToTest = nbFuntionsToLink;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * nbFuntionsToLink);
    func[0].name = (const uint8_t*) "initAudio";
    func[0].functionData = NULL;
    func[0].function = &initAudio;
    
    *functionsToSet = func;    
}

// ContextFinalizer()
//
// Set when the context extension is created.

void AirBgMusicContextFinalizer(FREContext ctx) { 
    NSLog(@"Entering ContextFinalizer()");
    
    NSLog(@"Exiting ContextFinalizer()");	
}



// AirFlurryInitializer()
//
// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void AirBgMusicInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
    
    NSLog(@"Entering ExtInitializer()");                    
    
	*extDataToSet = NULL;
	*ctxInitializerToSet = &AirBgMusicContextInitializer; 
	*ctxFinalizerToSet = &AirBgMusicContextFinalizer;
    
    NSLog(@"Exiting ExtInitializer()"); 
}