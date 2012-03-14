package com.dubink.ytauth
{
	import fl.controls.Button;
	import fl.controls.TextInput;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.net.FileFilter;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public class UploadForm extends MovieClip
	{
		private static var UPLOAD_URI:String = "http://gdata.youtube.com/feeds/api/users/default/uploads";
		
		public var tiTitle:TextInput;
		public var tiDescription:TextInput;
		public var tiFilename:TextInput;
		
		public var btnBrowse:Button;
		public var btnUpload:Button;
		
		private var infoData:String;
		private var fileData:String;
		private var slug:String;
		private var bodyData:String;
		
		private var upLoader:URLLoader;
		private var urlReq:URLRequest;
	
		private var fileRef:FileReference;
		
		private var fileFilters:Array = [new FileFilter("Videos (*.mov, *.avi, *.mp4, *.mpeg, *.mpg)", "*.mov;*.avi;*.mp4;*.mpeg;*.mpg")];
		
		public function UploadForm() {
			super();
			this.addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
		}
		
		private function init(e:Event):void {
			this.removeEventListener(Event.ADDED_TO_STAGE, init);
			btnBrowse.addEventListener(MouseEvent.CLICK, browseClickHandler);
			btnUpload.addEventListener(MouseEvent.CLICK, uploadClickHandler);
			btnUpload.enabled = false;
			fileRef = new FileReference();
		}
		
		private function browseClickHandler(me:MouseEvent):void {
			fileRef.addEventListener(Event.SELECT, selectHandler);
			fileRef.browse(fileFilters);
		}
		
		private function selectHandler(e:Event):void {
			trace("onselect fileSize:",fileRef.size);
			tiFilename.text = fileRef.name;
			
			if (fileRef.size > 64000000) {
				//File was too large to load
				return;
			}
			
			fileRef.addEventListener(IOErrorEvent.IO_ERROR, loadIOErrorHandler);
			fileRef.addEventListener(Event.COMPLETE, loadCompleteHandler);
			fileRef.addEventListener(ProgressEvent.PROGRESS, loadProgressHandler);
			fileRef.load();
		}
		
		private function uploadClickHandler(me:MouseEvent):void {
			 
			YTDirectUpload.inst.addEventListener(YTUploadEvent.SERVICE_UNAVAILABLE, serviceHandler, false, 0, true);
			YTDirectUpload.inst.addEventListener(YTUploadEvent.UPLOAD_COMPLETE, upCompleteHandler, false, 0, true); 
			YTDirectUpload.inst.uploadFile(tiTitle.text, tiDescription.text, fileRef);
			
		}
		
		private function serviceHandler(yte:YTUploadEvent):void {
			trace("SERVICE PROBLEM");
		}
		
		private function upCompleteHandler(yte:YTUploadEvent):void {
			trace("THE VIDEO ID:",yte.videoId);
		}
		
		private function loadIOErrorHandler(ioe:IOErrorEvent):void {
			trace("loadIOErrorHandler: " + ioe);
		}
		
		private function loadCompleteHandler(e:Event):void {
			trace("loadCompleteHandler: " + e);
			trace("fileSize:",fileRef.size);
			trace("fileType:",fileRef.type);
			btnUpload.enabled=true;
		}
		
		
		
		private function loadProgressHandler(pe:ProgressEvent):void {
			
			trace("loadProgressHandler bytesLoaded=" + pe.bytesLoaded + " bytesTotal=" + pe.bytesTotal);
		}
		
	}
}