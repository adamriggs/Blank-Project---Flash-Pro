package com.somerandomdude.tres.debug.nag
{
	public class Nag extends NagUtil
	{
		private static var instance:Nag;
      	private static var allowInstantiation:Boolean;
      
      public static function getInstance():Nag {
         if (instance == null) {
            allowInstantiation = true;
            instance = new Nag();
            instance.dispatchEventsEnabled=true;
            allowInstantiation = false;
          }
         return instance;
       }
      
      public function Nag():void {
         if (!allowInstantiation) {
            throw new Error("Error: Instantiation failed: Use SingletonDemo.getInstance() instead of new.");
          }
       }
	}
}