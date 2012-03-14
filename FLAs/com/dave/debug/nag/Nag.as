package com.somerandomdude.tres.debug.nag
{
	import flash.events.EventDispatcher;
	
	public class Nag extends EventDispatcher
	{
		private static var instance:NagUtil;	

      public function Nag():void {
		if(!Nag.instance) Nag.instance = new NagUtil();
      }
      
      public static function addEventListener(type:String, listener:Function, useCapture:Boolean, priority:int, useWeakReference:Boolean):void
      {
      	if(!Nag.instance) Nag.instance = new NagUtil();
      	Nag.instance.addEventListener(type, listener, useCapture, priority, useWeakReference);
      }
      
      public static function removeEventListener(type:String, listener:Function):void
      {
      	if(!Nag.instance) Nag.instance = new NagUtil();
      	Nag.instance.removeEventListener(type, listener);
      }
       
       public static function log(...rest):void
       {
       		if(!Nag.instance) Nag.instance = new NagUtil();
       		Nag.instance.log.apply(null, rest);
       }
       
       public static function warn(...rest):void
       {
       		if(!Nag.instance) Nag.instance = new NagUtil();
			Nag.instance.warn.apply(null, rest);
       }
       
       public static function info(...rest):void
       {
       		if(!Nag.instance) Nag.instance = new NagUtil();
			Nag.instance.info.apply(null, rest);
       }
       
       public static function error(...rest):void
       {
       		if(!Nag.instance) Nag.instance = new NagUtil();
			Nag.instance.error.apply(null, rest);
       }
       
       public static function debug(...rest):void
       {
       		if(!Nag.instance) Nag.instance = new NagUtil();
			Nag.instance.debug.apply(null, rest);
       }
       
       public static function set traceEnabled(value:Boolean):void
       {
       	if(!Nag.instance) Nag.instance = new NagUtil();
       	Nag.instance.traceEnabled=value;
       }
       
       public function set firebugConsoleEnabled(value:Boolean):void
		{
			
       	if(!Nag.instance) Nag.instance = new NagUtil();
       	Nag.instance.firebugConsoleEnabled=value;
		}
       
       public static function set dispatchEventsEnabled(value:Boolean):void
       {
       	if(!Nag.instance) Nag.instance = new NagUtil();
       	Nag.instance.dispatchEventsEnabled=value;
       }
       
       public static function set purgeInterval(value:int):void
		{	
       		if(!Nag.instance) Nag.instance = new NagUtil();
       		Nag.instance.purgeInterval=value;
		}
		
		public static function get purgeInterval():int
		{
			if(!Nag.instance) Nag.instance = new NagUtil();
       		return Nag.instance.purgeInterval;
		}
		
		public static function purge():void
		{
			if(!Nag.instance) Nag.instance = new NagUtil();
       		Nag.instance.purge();
		}
       
       
       public static function get fullLog():Array
		{
			return (Nag.instance)?Nag.instance.fullLog:[];
		}
		
		public static function get warnLog():Array
		{
			return (Nag.instance)?Nag.instance.warnLog:[];
		}
		
		public static function get infoLog():Array
		{
			return (Nag.instance)?Nag.instance.infoLog:[];
		}
		
		public static function get errorLog():Array
		{
			return (Nag.instance)?Nag.instance.errorLog:[];
		}
		
		public static function get debugLog():Array
		{
			return (Nag.instance)?Nag.instance.debugLog:[];
		}
       
       public static function toJSON():String
       {
       		return (Nag.instance)?Nag.instance.toJSON():"";
       }
       
       private function createInstance():void
       {
       	
       }
       
	}
}