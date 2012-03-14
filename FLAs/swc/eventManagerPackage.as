package swc {
	
	import flash.display.MovieClip;
	//import com.luaye.sample.ASampleClass;
	import com.adam.events.EventManager;
	import com.adam.events.MuleEvent;
		
	public class eventManagerPackage extends MovieClip{
		
		
		public function eventManagerPackage(){
			// you need to refer to a master class and all other classes you will be using.
			// for this case, we only want to use ASampleClass
			var a:Array = [EventManager,MuleEvent];
		}
	}
}