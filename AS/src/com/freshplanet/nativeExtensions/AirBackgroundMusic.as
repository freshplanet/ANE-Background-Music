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

package com.freshplanet.nativeExtensions
{
	import flash.external.ExtensionContext;
	import flash.system.Capabilities;
	
	
	public class AirBackgroundMusic
	{
		private static var extContext:ExtensionContext = null;
		
		private static var _instance:AirBackgroundMusic = null;
		
		public function AirBackgroundMusic()
		{
			trace("AirBackgroundMusic Context Created Constructor");
			extContext = ExtensionContext.createExtensionContext("com.freshplanet.AirBackgroundMusic", null);
			_instance = this;
		}
		
		public static function get backgroundMusic():AirBackgroundMusic {
			
			return _instance != null ? _instance : new AirBackgroundMusic()
		} 
		
		/**
		 * Init the audio session.
		 * Disable all background sounds that were playing before.
		 */
		public function init():void
		{
			if (this.useNativeExtension())
			{
				var ret:String = extContext.call("initAudio") as String;
			}
		}
		
		/**
		 * Check if the current device can use the native extension.
		 * For now, only iOS devices can do it.
		 */
		private function useNativeExtension():Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") > -1;
		}
		
	}
}





