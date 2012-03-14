// com.dave.ChromePlayPauseBtn
// Dave Cole
//
// Represents a play/pause button for a media player.  
//
// Expected Skin Elements:
//	play_btn		- Play button icon
//	play_btn_roll	- Play button roll-over
//	pause_btn		- Pause button icon
//	pause_btn_roll	- Pause button roll-over
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
	
	public class ChromePlayPauseBtn extends Chrome {
		public var play_btn, play_btn_roll, pause_btn, pause_btn_roll:MovieClip;
		private var paused:Boolean;
		
		public function ChromePlayPauseBtn(initObj:Object){
			super(initObj);
			init();
		}
		
		public function init(){
			trace("ChromePlayPauseBtn() init");
			
			play_btn_roll.visible = pause_btn.visible = pause_btn_roll.visible = false;
			
			paused = true;
			
			this.buttonMode = true;
			this.addEventListener(MouseEvent.MOUSE_OVER, pp_mouse);
			this.addEventListener(MouseEvent.MOUSE_OUT, pp_mouse);
			this.addEventListener(MouseEvent.CLICK, pp_mouse);
		}
		
		public override function lateInit(e:Event){
			
		}
		
		protected override function onPlaybackEvent(e:ChromeEvent){
			switch(e.args.type){
				case "stopped":
					setPaused(false);
					break;
				case "paused":
					setPaused(true);
					break;
				case "playing":
					setPaused(false);
					break;
			}
		}
		
		private function setPaused(m:Boolean){
			trace("ChromePlayPauseBtn.setPaused("+m+") paused=="+paused);
			if (m != paused){
				if (m){
					if (pause_btn_roll.visible){
						play_btn.visible = false;
						play_btn_roll.visible = true;
					} else {
						play_btn.visible = true;
						play_btn_roll.visible = false;
					}
					pause_btn.visible = false;
					pause_btn_roll.visible = false;
					
				} else {
					if (play_btn_roll.visible){
						pause_btn_roll.visible = true;
						pause_btn.visible = false;
					} else {
						pause_btn_roll.visible = false;
						pause_btn.visible = true;
					}
					play_btn.visible = false;
					play_btn_roll.visible = false;
					
				}
				paused = m;
			}
		}
		
		private function pp_mouse(e:MouseEvent){
			switch(e.type){
				case MouseEvent.CLICK:
					if (paused){
						setPaused(false);
						dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "play" } ));
					} else {
						setPaused(true);
						dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "pause" } ));
					}
					
					break;
				case MouseEvent.MOUSE_OVER:
					if (!paused){
						pause_btn_roll.visible = true;
						pause_btn.visible = false;
					} else {
						play_btn_roll.visible = true;
						play_btn.visible = false;
					}
					break;
				case MouseEvent.MOUSE_OUT:
					if (!paused){
						pause_btn_roll.visible = false;
						pause_btn.visible = true;
					} else {
						play_btn_roll.visible = false;
						play_btn.visible = true;
					}
					break;
			}
		}
	
	}
}