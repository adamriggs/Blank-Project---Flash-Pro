package com.dubink.ytauth
{
	import flash.system.Security;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.FileReference;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import flash.net.URLRequestMethod;
	import flash.utils.ByteArray;
	/* 
	import org.httpclient.HttpClient;
	import org.httpclient.HttpRequest;
	import org.httpclient.events.HttpDataEvent;
	import org.httpclient.events.HttpResponseEvent;
	import org.httpclient.events.HttpStatusEvent;
	import org.httpclient.http.Post;
	 */
	
	

	public class YTDirectUpload extends EventDispatcher
	{
		
		
		private static var BOUNDARY:String = "b35t0fu5ch4l";
		
		//private static var UPLOAD_URI:String = "http://www.dubink.com/php/ytpost.php";
		private static var UPLOAD_URI:String = "http://uploads.gdata.youtube.com/feeds/api/users/default/uploads";
		public var authToken:String;
		public var gDataKey:String;
		
		private var infoData:String;
		
		private var slug:String;
		private var bodyData:String;
		
		private var upLoader:URLLoader;
		//private var upStream:URLStream;
		private var urlReq:URLRequest;
		
		//private var client:HttpClient;
		//private var req:HttpRequest;
		
		protected static var _instance:YTDirectUpload;
		
		public function YTDirectUpload(lock:Class) {
			Security.loadPolicyFile( 'http://uploads.gdata.youtube.com/crossdomain.xml' );
			if (lock!=SingletonLock) {
				throw new Error("Invalid Singleton access. Please use YouTubeAuth.inst");
			}
		}

		public static function get inst():YTDirectUpload {
			if (_instance==null) {
				YTDirectUpload._instance = new YTDirectUpload(SingletonLock);
			}
			return YTDirectUpload._instance;
		}
		
		private function reset():void {
			infoData = null;
			slug = null;
			bodyData = null;
		}
		
		
		public function uploadFile(title:String, description:String, file:FileReference):void {
			trace("-YTDirectUpload.uploadFile("+title+", "+description+", "+file+")");
			if (this.authToken==null) {
				throw new Error("NO Auth Token set to upload file.");
			}
			reset();
			
			infoData = '<?xml version="1.0"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" xmlns:yt="http://gdata.youtube.com/schemas/2007">'
						+ '<media:group><media:title type="plain">' + title + '</media:title><media:description type="plain">' + description 
						+ '</media:description><media:category scheme="http://gdata.youtube.com/schemas/2007/categories.cat">Sports</media:category>'
						+ '<media:keywords>bestofuschallenge</media:keywords></media:group></entry>';
			
			/*
			infoData = '<?xml version="1.0"?><entry xmlns="http://www.w3.org/2005/Atom" xmlns:media="http://search.yahoo.com/mrss/" xmlns:yt="http://gdata.youtube.com/schemas/2007">'
						+ '<media:group><media:title type="plain"><![CDATA[' + title + ']]></media:title><media:description type="plain"><![CDATA[' + description 
						+ '//></media:description><media:category scheme="http://gdata.youtube.com/schemas/2007/categories.cat">Sports</media:category>'
						+ '<media:keywords>bestofuschallenge</media:keywords></media:group></entry>';
			*/
			slug = file.name;		
			
			var authHead:URLRequestHeader = new URLRequestHeader('Authorization', 'AuthSub token="' + authToken + '"');
			var gDataHead:URLRequestHeader = new URLRequestHeader('GData-Version', '2');
			var keyHead:URLRequestHeader = new URLRequestHeader('X-GData-Key', 'key=' + gDataKey);
			var slugHead:URLRequestHeader = new URLRequestHeader('Slug', slug);

			urlReq = new URLRequest(UPLOAD_URI);
			urlReq.method = URLRequestMethod.POST;
			
			urlReq.contentType = 'multipart/related; boundary="'+BOUNDARY+'"';
			
			urlReq.requestHeaders.push(authHead);
			urlReq.requestHeaders.push(gDataHead);
			urlReq.requestHeaders.push(keyHead);
			urlReq.requestHeaders.push(slugHead);

			bodyData = "--"+BOUNDARY+"\n";
			bodyData += "Content-Type: application/atom+xml; charset=UTF-8\n";
			bodyData += "\n";
			bodyData += infoData+"\n";
			bodyData += "--"+BOUNDARY+"\n";
			bodyData += "Content-Type: application/octet-stream\n";
			bodyData += "Content-Transfer-Encoding: binary\n\n";
			
			var bodyBytes:ByteArray = new ByteArray();
			bodyBytes.writeUTFBytes(bodyData);
			bodyBytes.writeBytes(file.data, 0, file.data.bytesAvailable);
			bodyBytes.writeUTFBytes("\n--"+BOUNDARY+"--\n");
			
			urlReq.data = bodyBytes;
			
			upLoader = new URLLoader();
			
			initListeners(upLoader);
			
			upLoader.load(urlReq);
		}
		
		
		
		
		private function initListeners(dispatcher:IEventDispatcher):void {
			dispatcher.addEventListener(ErrorEvent.ERROR, uploadErrorHandler);
        	dispatcher.addEventListener(IOErrorEvent.IO_ERROR, uploadIOErrorHandler);
        	dispatcher.addEventListener(SecurityErrorEvent.SECURITY_ERROR, uploadSecurityHandler);
        	dispatcher.addEventListener(HTTPStatusEvent.HTTP_STATUS, uploadStatusHandler);
        	dispatcher.addEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.addEventListener(Event.COMPLETE, uploadCompleteHandler);
		}
		
		private function removeListeners(dispatcher:IEventDispatcher):void {
			dispatcher.removeEventListener(ErrorEvent.ERROR, uploadErrorHandler);
        	dispatcher.removeEventListener(IOErrorEvent.IO_ERROR, uploadIOErrorHandler);
        	dispatcher.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, uploadSecurityHandler);
        	dispatcher.removeEventListener(HTTPStatusEvent.HTTP_STATUS, uploadStatusHandler);
        	dispatcher.removeEventListener(ProgressEvent.PROGRESS, progressHandler);
			dispatcher.removeEventListener(Event.COMPLETE, uploadCompleteHandler);
		}
		
		private function progressHandler(pe:ProgressEvent):void {
			trace("bytesLoaded: "+pe.bytesLoaded+", bytesTotal: "+pe.bytesTotal);
		}
		
		private function uploadErrorHandler(ee:ErrorEvent):void {
			trace("YTDirectUpload Error: "+ee.toString());
			removeListeners(upLoader);
		}
		
		private function uploadIOErrorHandler(ioe:IOErrorEvent):void  {
			trace("YTDirectUpload IOError: "+ioe.toString());
			removeListeners(upLoader);
		}
		
		private function uploadSecurityHandler(see:SecurityErrorEvent):void {
			trace("YTDirectUpload Security Error: "+see.toString());
		}
		
		
		private function uploadStatusHandler(hse:HTTPStatusEvent):void {
			trace("YTDirectUpload HTTP Status:"+hse.status);
			
			if (hse.status==503) {
				this.dispatchEvent(new YTUploadEvent(YTUploadEvent.SERVICE_UNAVAILABLE));
			}
		}
		
		
		
		private function uploadCompleteHandler(e:Event):void {
			trace("YTDirectUpload uploadCompleteHandler");
			var entry:XML = XML(upLoader.data);
			var vid:String = entry..*::videoid;
			trace("videoid:",vid);
			removeListeners(upLoader);
			var yte:YTUploadEvent = new YTUploadEvent(YTUploadEvent.UPLOAD_COMPLETE);
			yte.videoId = vid;
			this.dispatchEvent(yte);
		}
		
	}
}

class SingletonLock {}