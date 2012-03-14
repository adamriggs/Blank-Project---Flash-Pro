package swc{
	
	import flash.display.MovieClip;
	//import com.luaye.sample.ASampleClass;
	import com.adam.utils.AppData;
		
	public class appDataPackage extends MovieClip{
		
		
		public function appDataPackage(){
			// you need to refer to a master class and all other classes you will be using.
			// for this case, we only want to use ASampleClass
			var a:Array = [AppData];
		}
	}
}
