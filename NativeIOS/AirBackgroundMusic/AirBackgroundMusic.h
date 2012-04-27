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


#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"
#import <AVFoundation/AVFoundation.h>


@interface AirBackgroundMusic : NSObject

@end

FREObject initAudio(FREContext context, void* functionData, uint32_t argc, FREObject argv[]);

void AirBgMusicContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, 
                                  uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);

void AirBgMusicContextFinalizer(FREContext ctx);

void AirBgMusicInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);