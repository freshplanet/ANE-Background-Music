//////////////////////////////////////////////////////////////////////////////////////
//
//  Copyright 2012 Freshplanet (http://freshplanet.com | opensource@freshplanet.com)
//  
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//  
//    http://www.apache.org/licenses/LICENSE-2.0
//  
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//  
//////////////////////////////////////////////////////////////////////////////////////

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

// initAudio()
// Set and active the new session audio.
// The session audio used is AVAudioSessionCategoryPlayback
// @see http://developer.apple.com/library/ios/#documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Configuration/Configuration.html#//apple_ref/doc/uid/TP40007875-CH3-SW1
// returns the newly activated session name
DEFINE_ANE_FUNCTION(initAudio)
{
    // silence everything.
    [[AVAudioSession sharedInstance] setActive: NO error: nil];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:NULL];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    NSString* category =  [[AVAudioSession sharedInstance] category];
    
    const char *str = [category UTF8String];
    
    // Prepare for AS3
    FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*)str, &retStr);
    return retStr;
}

// AirBgMusicContextInitializer()
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

// AirBgMusicContextFinalizer()
//
// Set when the context extension is created.
void AirBgMusicContextFinalizer(FREContext ctx) {}



// AirBgMusicInitializer()
//
// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void AirBgMusicInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirBgMusicContextInitializer; 
    *ctxFinalizerToSet = &AirBgMusicContextFinalizer;
    
}