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
		

		public function init():void
		{
			if (this.useNativeExtension())
			{
				var ret:String = extContext.call("initAudio") as String;
			}
		}
		
		private function useNativeExtension():Boolean
		{
			return Capabilities.manufacturer.indexOf("iOS") > -1;
		}
		
	}
}





