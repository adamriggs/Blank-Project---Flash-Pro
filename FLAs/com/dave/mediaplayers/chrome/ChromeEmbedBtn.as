// com.dave.ChromeEmbedBtn
// Dave Cole
//
//	Represents an embed button for a given media player.
// 
// Expected Skin Elements:
//	btn			- Embed button icon
//	btn_roll	- Embed Screen button roll-over state
//
// Inherited functions:
//	show();
//	hide();
//	all other functions are overridden below.
//
package com.dave.mediaplayers.chrome {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	
	import com.dave.mediaplayers.chrome.events.*;
	
	public class ChromeEmbedBtn extends Chrome {
		public var btn, btn_roll:MovieClip;
		
		public function ChromeEmbedBtn(initObj:Object){
			super(initObj);
			init();
		}
		
		public function init(){
			//this.visible = false;
			trace("ChromeEmbedBtn() init");
			
			btn_roll.visible = false;
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, embed_mouse);
			this.addEventListener(MouseEvent.MOUSE_OUT, embed_mouse);
			this.addEventListener(MouseEvent.CLICK, embed_mouse);
		}
		
		public override function lateInit(e:Event){
			
		}
		
		
		protected function embed_mouse(e:MouseEvent){
			switch(e.type){
				case MouseEvent.CLICK:
					dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "embed" } ));
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