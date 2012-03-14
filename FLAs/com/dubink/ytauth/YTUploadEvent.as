package com.dubink.ytauth
{
	import flash.events.Event;

	public class YTUploadEvent extends Event
	{
		public static var UPLOAD_COMPLETE:String = "event_YTAuthUploadComplete";
		public static var SERVICE_UNAVAILABLE:String = "event_YTAuthServiceUnavailable";
		
		public var videoId:String;
		
		public function YTUploadEvent(type:String)
		{
			super(type, false, false);
		}
		
	}
}