// com.dave.ChromeCollection
// Dave Cole
//
// A ChromeCollection is a container class that allows you to gather several different chrome elements into one collection, allowing them to be added and scaled as a group.
//
package com.dave.mediaplayers.chrome {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.dave.mediaplayers.chrome.*;
	import com.dave.mediaplayers.chrome.events.*;
	
	public class ChromeCollection extends Chrome {
		protected var chrome:Array;
		private var i,j:int;
		
		public function ChromeCollection(initObj:Object){
			super(initObj);
			chrome = new Array();
			
			init();
		}
		
		public function init(){
			trace("ChromeCollection() init");
			
		}
		
		public override function lateInit(e:Event){
			
		}
		
		public function addChrome(c:Chrome){
			addChild(c);
			c.addEventListener(ChromeEvent.CONTROLEVENT, onControlEvent);
			chrome.push(c);
		}
		
		public function removeChrome(c:Chrome){
			for(i=0; i < chrome.length; i++){
				if (chrome[i] == c){
					chrome[i].destroy(); // destroy removes the child
					chrome[i] = null;
					chrome.splice(i, 1);
				}
			}
		}
		
		public function removeAllChrome(){
			for (i=0; i < chrome.length; i++){
				chrome[i].destroy(); // destroy removes the child
				chrome[i] = null;
			}
			chrome = new Array();
		}
		
		protected override function onPlaybackEvent(e:ChromeEvent){
			// pass event on to children
			dispatchEvent(new ChromeEvent(e.type, { type: e.args.type, value: e.args.value } ));
		}
		
		protected function onControlEvent(e:ChromeEvent){
			// pass event up to parent (which is listening via the super constructor)
			dispatchEvent(new ChromeEvent(e.type, { type: e.args.type, value: e.args.value } ));
		}
		
		
		// arrange x positions and widths of all child chrome, scaling the scrubber dynamically based on remaining width.
		public override function setWidth(width:Number){
			trace("cc.setWidth("+width+")");
			for (i=0; i < chrome.length; i++){
				
				if (i == 0){
					chrome[i].x = 0 + chrome[i].leftPadding;
				} else {
					chrome[i].x = chrome[i - 1].x + chrome[i - 1].width + chrome[i - 1].rightPadding + chrome[i].leftPadding;
				}
				
				if (chrome[i] is ChromeScrubber){
					// if scrubber, set width = to available remaining width - all trailing widths
					var rightWidth:Number = 0;
					for (j=(i + 1); j < chrome.length; j++){
						rightWidth += (chrome[j].width + chrome[j].leftPadding + chrome[j].rightPadding);
					}
					//trace("rightWidth == "+rightWidth);
					chrome[i].setWidth(Math.max(0, width - (chrome[i].x + chrome[i].leftPadding + chrome[i].rightPadding + rightWidth)));
				}
			}
		}
		
		public override function destroy(){
			removeAllChrome();
			_parent.removeEventListener(ChromeEvent.PLAYBACKEVENT, onPlaybackEvent);
			_parent.removeChild(this);
		}
		
		public override function show(){
			this.visible = true;
		}
		
		public override function hide(){
			this.visible = false;
		}
		
	
	}
}