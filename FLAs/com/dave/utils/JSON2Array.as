// JSON2Array
// AS3 v1.0
// Copyright 2007 Dave Cole - All Rights Reserved
// 
// Requires:
//
// com.adobe.serialization.json.*;
//
// Usage:
//
// jsonObj = new JSON2Array( {filename } );
// 
// jsonObj.onLoaded = function(){ // use values in JSON2Array.dataArray }
//
// jsonObj.load(filename);
//

package com.dave.utils{
	import flash.events.*;
	import flash.net.*;
	import flash.utils.*;
	import com.adobe.serialization.json.JSON;
	
	public class JSON2Array extends EventDispatcher {
		public var loader:URLLoader;
		public var file:String;
		public var onLoaded:Function;
		public var dataArray:Array;
		
		public function JSON2Array(...filename){
			loader = new URLLoader();
			//loader.dataFormat = DataFormat.TEXT;
			loader.addEventListener( Event.COMPLETE, handleComplete );
			loader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			onLoaded = function(){};
			
			if (filename.length > 0){
				load(filename[0]);
			} 
		}
		
		public function load(filename:String){
			file = filename;
			loader.load( new URLRequest(filename + "?rnd="+Math.floor(Math.random() * 10000000)) );
		}
		
		private function handleComplete(event:Event):void{
			try {
				//trace("JSON: "+event.target.data);
				
				if (event.target.data.indexOf("[",0) >= 0 && event.target.data.indexOf("[",0) < 10){
					dataArray = JSON.decode( event.target.data );
				} else {
					dataArray = JSON.decode( "["+event.target.data+"]" );
				}
				
				trace("com.dave.utils.JSON2Array: Received '"+file+"', Parsed "+dataArray.length+" records.");
				
				this.onLoaded();
			} catch ( e:TypeError ){
				trace("com.dave.utils.JSON2Array: ERROR loading JSON File '"+file+"': "+e.message);
			}
		}
		
		private function ioErrorHandler(e:Event){
			trace("com.dave.utils.JSON2Array: IOERROR loading JSON File '"+file);
		}
	}
}