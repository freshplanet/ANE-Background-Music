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

FREContext AirBackgroundMusicCtx = nil;


@implementation AirBackgroundMusic

#pragma mark - Singleton

static AirBackgroundMusic *sharedInstance = nil;

+ (AirBackgroundMusic *)sharedInstance
{
    if (sharedInstance == nil)
    {
        sharedInstance = [[super allocWithZone:NULL] init];
    }

    return sharedInstance;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return self;
}

@end


#pragma mark - C interface

/* Set and active the new session audio.
 * 
 * The session audio used is AVAudioSessionCategoryPlayback
 * @see http://developer.apple.com/library/ios/#documentation/Audio/Conceptual/AudioSessionProgrammingGuide/Configuration/Configuration.html#//apple_ref/doc/uid/TP40007875-CH3-SW1
 */
DEFINE_ANE_FUNCTION(initAudio)
{
    NSLog(@"Entering initAudio()");

    NSError *sessionError = nil;
    [[AVAudioSession sharedInstance] setActive:NO error:&sessionError];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&sessionError];
    [[AVAudioSession sharedInstance] setActive:YES error:&sessionError];
    
    NSString *category = [[AVAudioSession sharedInstance] category];
    
    // Prepare for AS3
    const char *str = [category UTF8String];
    FREObject retStr;
    FRENewObjectFromUTF8(strlen(str)+1, (const uint8_t*) str, &retStr);
    
    NSLog(@"Exiting initAudio()");
    
    return retStr;
}


#pragma mark - ANE setup

/* AirBackgroundMusicExtInitializer()
 * The extension initializer is called the first time the ActionScript side of the extension
 * calls ExtensionContext.createExtensionContext() for any context.
 *
 * Please note: this should be same as the <initializer> specified in the extension.xml 
 */
void AirBackgroundMusicExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) 
{
    NSLog(@"Entering AirBackgroundMusicExtInitializer()");

    *extDataToSet = NULL;
    *ctxInitializerToSet = &AirBackgroundMusicContextInitializer;
    *ctxFinalizerToSet = &AirBackgroundMusicContextFinalizer;

    NSLog(@"Exiting AirBackgroundMusicExtInitializer()");
}

/* AirBackgroundMusicExtFinalizer()
 * The extension finalizer is called when the runtime unloads the extension. However, it may not always called.
 *
 * Please note: this should be same as the <finalizer> specified in the extension.xml 
 */
void AirBackgroundMusicExtFinalizer(void* extData) 
{
    NSLog(@"Entering AirBackgroundMusicExtFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting AirBackgroundMusicExtFinalizer()");
    return;
}

/* ContextInitializer()
 * The context initializer is called when the runtime creates the extension context instance.
 */
void AirBackgroundMusicContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet)
{
    NSLog(@"Entering ContextInitializer()");

    /* The following code describes the functions that are exposed by this native extension to the ActionScript code.
     * As a sample, the function isSupported is being provided.
     */
    *numFunctionsToTest = 1;

    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
    func[0].name = (const uint8_t*) "initAudio";
    func[0].functionData = NULL;
    func[0].function = &initAudio;

    *functionsToSet = func;

    AirBackgroundMusicCtx = ctx;

    NSLog(@"Exiting ContextInitializer()");
}

/* ContextFinalizer()
 * The context finalizer is called when the extension's ActionScript code
 * calls the ExtensionContext instance's dispose() method.
 * If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls ContextFinalizer().
 */
void AirBackgroundMusicContextFinalizer(FREContext ctx) 
{
    NSLog(@"Entering ContextFinalizer()");

    // Nothing to clean up.
    NSLog(@"Exiting ContextFinalizer()");
    return;
}


