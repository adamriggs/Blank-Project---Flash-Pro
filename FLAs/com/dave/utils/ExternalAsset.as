// ExternalAsset (extends Sprite)
// AS3 v1.0
// Copyright 2007 Dave Cole - All Rights Reserved
// 
//
//  License: Only Dave Cole and active Mekanism employees or contractors may use this code.
//
// Usage:
//
// asset = new ExternalAsset( args );
// 
// asset.onLoaded = function(){ ... process the asset, once loaded, the asset is a child of the ExternalAsset ... }
//
// addChild(asset);
//

package com.dave.utils{
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.utils.*;
	import flash.system.*;
	
	public class ExternalAsset extends Sprite{
		public var loader:Loader;
		public var context:LoaderContext;
		public var file:String;
		public var onLoaded:Function;
		public var inner:Bitmap;
		public var policyOverride:Boolean;
		private var smoothing:Boolean;
		private var success:Boolean;
		private var isAS2SWF:Boolean;
		private var isAS3SWF:Boolean;
		public var innerSWF:AVM1Movie;
		public var innerAS3SWF:MovieClip;
		public var extra:Object;
		
		public function ExternalAsset(_policyOverride=false, _smoothing=false, _isAS2SWF=false, _isAS3SWF=false){
			loader = new Loader();
			policyOverride = _policyOverride;
			if(Capabilities.playerType == "External"){
				policyOverride = false;
			} else {
				policyOverride = true;
			}
			
			if (policyOverride){
				context = new LoaderContext(true);
				context.checkPolicyFile = true;
			}
			isAS2SWF = _isAS2SWF;
			isAS3SWF = _isAS3SWF;
			smoothing = _smoothing;
			success = true;
			extra = {};
			
			loader.contentLoaderInfo.addEventListener( Event.INIT, handleInit );
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			onLoaded = function(target:Object, success:Boolean){ };
			
			/*if (filename.length > 0){
				load(filename[0]);
			} */
			
		}
		
		public function load(filename:String){
			file = filename;
			loader.load( new URLRequest(filename),context);
		}
		
		public function unload(){
			loader.unload();
		}
		
		private function handleInit(event:Event):void{
			try {
				
				if (!policyOverride){
					trace('b');
					if (!isAS2SWF && !isAS3SWF){
						
						inner = event.target.content;
						trace("inner == "+inner);
						if (smoothing){
							inner.smoothing = true;
						}
						
						addChild(inner);
					} else if (isAS2SWF){
						innerSWF = event.target.content;
						
						addChild(innerSWF);
					} else if (isAS3SWF){
						innerAS3SWF = event.target.content;
						addChild(innerAS3SWF);
					}
					
					loader = null;
					
				} else {
					trace('c');
					
					addChild(loader);
				}
				trace('d '+this.onLoaded);
				this.onLoaded(this, true);
				trace('e');
			
			} catch ( e:TypeError ){
				trace("com.dave.utils.ExternalAsset: ERROR loading File '"+file+"': "+e.message);
				this.onLoaded(this, false);
			}
		}
		
		public function ioErrorHandler(e:Event){
			trace("loader error! -  error loading file "+file);
			this.onLoaded(this, false)
		}
	}
}