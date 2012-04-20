//
//  AirBackgroundMusic.h
//  AirBackgroundMusic
//
//  Created by Thibaut Crenn on 4/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

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