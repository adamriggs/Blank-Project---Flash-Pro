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
	import org.FlepStudio.ToolTip;
	import com.app.Application;
	
	import com.dave.mediaplayers.chrome.events.*;
	
	public class ChromeTBUCEmbedBtn extends ChromeEmbedBtn {
		//public var btn, btn_roll:MovieClip;
		private var tool_tip:ToolTip;
		private var phrases:XMLList;
		
		public function ChromeTBUCEmbedBtn(initObj:Object){
			super(initObj);
			phrases = Application.xml.LOCALIZATION.PHRASES.(@LANGUAGE == Application.locale);
			btn.txt.text = String(phrases.EMBED).toUpperCase();
			btn_roll.txt.text = String(phrases.EMBED).toUpperCase();
			//btn.txt.width = btn.hot.width = btn.txt.textWidth + 8;
			//btn_roll.txt.width = btn_roll.hot.width = btn_roll.txt.textWidth + 8;
		}
		
		
		protected override function embed_mouse(e:MouseEvent){
			switch(e.type){
				case MouseEvent.CLICK:
					if(tool_tip!=null)
					{
						tool_tip.destroy();
						tool_tip=null;
					}
					tool_tip=new ToolTip(0xFFCC00,0x000000,10,"Lubalin",phrases.EMBEDCODECOPIEDTOCLIPBOARD);
					Application.shell.addChild(tool_tip);
					dispatchEvent(new ChromeEvent(ChromeEvent.CONTROLEVENT, { type: "embed" } ));
					break;
				case MouseEvent.MOUSE_OVER:
					//tool_tip=new ToolTip(0xFFCC00,0x000000,10,"Lubalin",phrases.EMBED);
					//Application.shell.addChild(tool_tip);
					btn_roll.visible = true;
					btn.visible = false;
					break;
				case MouseEvent.MOUSE_OUT:
					if(tool_tip!=null)
					{
						tool_tip.destroy();
						tool_tip=null;
					}
					btn_roll.visible = false;
					btn.visible = true;
					break;
			}
		}
	}
}