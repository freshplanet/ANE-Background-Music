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

package com.freshplanet.ane.AirBackgroundMusic.functions;

import android.content.Context;
import android.media.AudioManager;
import android.media.AudioManager.OnAudioFocusChangeListener;
import android.util.Log;

import com.adobe.fre.FREContext;
import com.adobe.fre.FREFunction;
import com.adobe.fre.FREObject;
import com.adobe.fre.FREWrongThreadException;

/**
 * Example function.
 *
 * Create a new class for each function in your API. Don't forget to add them in
 * AirBackgroundMusicExtensionContext.getFunctions().
 */
public class InitFunction implements FREFunction 
{
	private static String TAG = "[AirBackgroundMusic] InitFunction -";
	
	public FREObject call(FREContext context, FREObject[] args) 
	{
		Log.d(TAG, "Entering call");
		
		// Before your App starts playing any audiuo, it should hold the audio focus for the stream it will be using
		AudioManager am = (AudioManager) context.getActivity().getSystemService(Context.AUDIO_SERVICE);
		
		// 
		OnAudioFocusChangeListener afAudioFocusChangeListener = new OnAudioFocusChangeListener() {
			public void onAudioFocusChange(int focusChange) {
				Log.d(TAG, "afAudioFocusChangeListener - focusChange : " + focusChange);
			}
		};
		
		// Request an Audio change
		int result = am.requestAudioFocus(afAudioFocusChangeListener, 
										// We are going to Stream Music  
										AudioManager.STREAM_MUSIC, 
										// Request permanent focus
										AudioManager.AUDIOFOCUS_GAIN);
		
		//
		if (result == AudioManager.AUDIOFOCUS_REQUEST_GRANTED) {
			Log.d(TAG, "Audio focus granted! result = " + result);
		} else {
			Log.d(TAG, "Audio Focus was not granted. result = " + result);
		}
		
		Log.d(TAG, "Exiting call");
		
		try {
			return FREObject.newObject(result);
		} catch (FREWrongThreadException exception) {
			Log.d(TAG, exception.getLocalizedMessage());
			return null;
		}
	}
}
