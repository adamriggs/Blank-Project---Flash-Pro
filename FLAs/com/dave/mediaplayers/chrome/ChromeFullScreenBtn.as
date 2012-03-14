// com.dave.ChromeFullScreenBtn
// Dave Cole
//
// Represents a full screen button for a media player.  
//
// Expected Skin Elements:
//	btn			- Full Screen button icon
//	btn_roll	- Full Screen button roll-over state
//
// inherited functions:
// show();
// hide();
//
package com.dave.mediaplayers.chrome {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.dave.mediaplayers.chrome.events.*;
	
	public class ChromeFullScreenBtn extends Chrome {
		public var btn, btn_roll:MovieClip;
		
		public function ChromeFullScreenBtn(initObj:Object){
			super(initObj);
			init();
		}
		
		public function init(){
			trace("ChromeFullScreenBtn() init");
			
			btn_roll.visible = false;
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, fs_mouse);
			this.addEventListener(MouseEvent.MOUSE_OUT, fs_mouse);
			this.addEventListener(MouseEvent.CLICK, fs_mouse);
		}
		
		public override function lateInit(e:Event){
			
		}
		
		
		
		private function fs_mouse(e:MouseEvent){
			switch(e.type){
				case MouseEvent.CLICK:
					dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "fullscreen" } ));
					break;
				case MouseEvent.MOUSE_OVER:
					btn_roll.visible = true;
					btn.visible = false;
					break;
				case MouseEvent.MOUSE_OUT:
					btn_roll.visible = false;
					btn.visible = true;
					break;
			}
		}
	
	}
}