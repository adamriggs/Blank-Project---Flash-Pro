package swc{
	
	import flash.display.MovieClip;
	//import com.luaye.sample.ASampleClass;
	import com.adam.apis.Flickr;
		
	public class flickrPackage extends MovieClip{
		
		
		public function flickrPackage(){
			// you need to refer to a master class and all other classes you will be using.
			// for this case, we only want to use ASampleClass
			var a:Array = [Flickr];
		}
	}
}
