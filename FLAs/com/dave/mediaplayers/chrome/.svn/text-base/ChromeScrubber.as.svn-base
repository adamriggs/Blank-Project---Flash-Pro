// com.dave.ChromeScrubber
// Dave Cole
//
// Represents a scrubber class for a media player.  
//
// inherited functions:
// show();
// hide();
//
// Expected Skin Elements:
//
//	well - a movie clip containing a bitmap of the scroll well
//	buffer - a movie clip containing a bitmap of the scroll well when its buffered; often it is smart to use the same bitmap as the well and desaturate the well.  This class will mask it out as needed.
//	nub - a movie clip containing a bitmap of the scroll nub; if you wish the nub to be a progress bar style instead of a nub style, make the nub an empty movie clip and set 'useProgressBar' to true.
//	progressbar - a movie clip containing a bitmap of the progress bar, if used; this class will mask it out as needed.
//
package com.dave.mediaplayers.chrome {
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.geom.Point;
	
	import com.dave.mediaplayers.chrome.events.*;
	
	public class ChromeScrubber extends Chrome {
		public var well, buffer, nub, progressbar:MovieClip;
		private var masker_buffer, masker_progressbar, hotspot, hotspotinner:Sprite;
		private var loadProgress, seekProgress:Number;
		
		private var useProgressBar:Boolean = false;
		
		public function ChromeScrubber(initObj:Object){
			super(initObj);
			init();
		}
		
		public function init(){
			trace("ChromeScrubber() init");
			
			loadProgress = seekProgress = 0;
			progressbar.width = buffer.width = 0;
			
			masker_buffer = new Sprite();
			masker_buffer.name = 'masker_buffer';
			masker_buffer.graphics.beginFill(0x333333, 0);
			masker_buffer.graphics.drawRect(0, 0, 600, buffer.height + buffer.y + 5); 
			masker_buffer.graphics.endFill();
			addChild(masker_buffer);
			buffer.mask = masker_buffer;
			masker_buffer.width = buffer.width;
			
			masker_progressbar = new Sprite();
			masker_progressbar.name = 'masker_progressbar';
			masker_progressbar.graphics.beginFill(0x333333, 0);
			masker_progressbar.graphics.drawRect(0, 0, 600, progressbar.height + progressbar.y + 5); 
			masker_progressbar.graphics.endFill();
			addChild(masker_progressbar);
			progressbar.mask = masker_progressbar;
			masker_progressbar.width = progressbar.width;
			
			if (!useProgressBar){
				progressbar.visible = false;
			}
			
			hotspot = new Sprite();
			hotspot.name = 'hotspot';
			hotspotinner = new Sprite();
			hotspotinner.name = 'hotspotinner';
			hotspotinner.graphics.beginFill(0x333333, 0);
			hotspotinner.graphics.drawRect(0, 0, well.width, well.height + well.y + 5); 
			hotspotinner.graphics.endFill();
			addChild(hotspot);
			hotspot.addChild(hotspotinner);
			//hotspot.width = well.width;
			
			hotspot.addEventListener(MouseEvent.MOUSE_DOWN, hotspot_mouse);
			hotspot.addEventListener(MouseEvent.MOUSE_UP, hotspot_mouse);
			hotspot.buttonMode = true;
			
		}
		
		public override function lateInit(e:Event){
			
		}
		
		protected override function onPlaybackEvent(e:ChromeEvent){
			switch(e.args.type){
				case "stopped":
					
					break;
				case "headposition":
					setSeekProgress(e.args.value);
					break;
				case "loadprogress":
					setLoadProgress(e.args.value);
					break;
			}
		}
		
		public override function setWidth(n:Number){
			trace("ChromeScrubber.setWidth("+n+")");
			well.width = progressbar.width = buffer.width = hotspot.width = n;
			hotspot.removeChild(hotspotinner);
			hotspotinner = new Sprite();
			hotspotinner.name = 'hotspotinner';
			hotspotinner.graphics.beginFill(0x333333, 0);
			hotspotinner.graphics.drawRect(0, 0, well.width, well.height + well.y + 5); 
			hotspotinner.graphics.endFill();
			hotspot.addChild(hotspotinner);
			setLoadProgress(loadProgress);
			setSeekProgress(seekProgress);
		}
		
		/*
		private function resetBuffer(){
			setLoadProgress(0);
		}
		
		private function resetProgress(){
			setSeekProgress(0);
		}
		*/
		
		// 0 < progress < 1
		private function setLoadProgress(progress:Number){
			trace("ChromeScrubber.setLoadProgress("+progress+")");
			loadProgress = Math.min(1,Math.max(0,progress));
			masker_buffer.width = well.width * loadProgress;
		}
		
		// 0 < progress < 1
		private function setSeekProgress(progress:Number){
			seekProgress = Math.min(1,Math.max(0,progress));
			if (useProgressBar){
				masker_progressbar.width = well.width * seekProgress;
			} 
			nub.x = (well.width * seekProgress) - nub.width/2;
		}
		
		private function hotspot_mouse(e:MouseEvent){
			switch(e.type){
				case MouseEvent.MOUSE_DOWN:
					this.addEventListener(MouseEvent.MOUSE_MOVE, scrub);
					setSeekProgress(Math.min(1, Math.max(0,(hotspot.mouseX * hotspot.scaleX) / hotspot.width)));
					
					//dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "seek", value: seekProgress } ));
																												   
					break;
				case MouseEvent.MOUSE_UP:
					setSeekProgress(Math.min(1, Math.max(0,(hotspot.mouseX * hotspot.scaleX) / hotspot.width)));
					
					dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "seek", value: seekProgress } ));
																												   
					try {
						this.removeEventListener(MouseEvent.MOUSE_MOVE, scrub);
					} catch (e:Error){}
					break;
			}
		}
		
		private function scrub(e:MouseEvent){
			if (e.buttonDown){
				setSeekProgress(Math.min(1, Math.max(0,(hotspot.mouseX * hotspot.scaleX) / hotspot.width)));
				//dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "seek", value: seekProgress } ));
			} else {
				setSeekProgress(Math.min(1, Math.max(0,(hotspot.mouseX * hotspot.scaleX) / hotspot.width)));
				dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "seek", value: seekProgress } ));
				this.removeEventListener(MouseEvent.MOUSE_MOVE, scrub);
			}
		}
		
		
	}
}