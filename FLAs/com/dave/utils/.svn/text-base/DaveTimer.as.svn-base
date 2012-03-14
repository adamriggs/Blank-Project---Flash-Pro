package com.dave.utils
{
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	public class DaveTimer
	{
		   protected static var _timer:Timer;
	       public function DaveTimer()
	       {
	              
	       }
		   
		   public static function wait(milliseconds:int, callback:Function, repeats:int=1){
				 _timer = new Timer(milliseconds,repeats);
				 _timer.addEventListener(TimerEvent.TIMER, callback);
				 _timer.start();
		   }
		   
		   public static function stopTimer(){
				_timer.stop();   
		   }
	}
}
