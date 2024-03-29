﻿/**
* SWFBridgeAS3 by Grant Skinner. March 11, 2007
* Visit www.gskinner.com/blog for documentation, updates and more free code.
*
* You may distribute this class freely, provided it is not modified in any way (including
* removing this header or changing the package path).
*
* Please contact info@gskinner.com prior to distributing modified versions of this class.
*/

package com.gskinner.utils {
	import flash.net.LocalConnection;
	import flash.events.EventDispatcher;
	import flash.events.Event;
	
	public class SWFBridgeAS3 extends EventDispatcher {
		private var baseID:String;
		private var myID:String;
		private var extID:String;
		private var lc:LocalConnection;
		private var _connected:Boolean=false;
		private var host:Boolean=true;
		private var clientObj:Object;
		
		public function SWFBridgeAS3(p_id:String,p_clientObj:Object) {
			baseID = p_id.split(":").join("");
			lc = new LocalConnection();
			lc.client = this;
			clientObj = p_clientObj;
			
			
			
			try {
				lc.connect(baseID+"_host");
			} catch(e:ArgumentError) {
				host = false;
			}
			
			
				
			myID = baseID+((host)?"_host":"_guest");
			extID = baseID+((host)?"_guest":"_host");
			if (!host) {
				lc.connect(myID);
				lc.send(extID,"com_gskinner_utils_SWFBridge_init");
			}
		}
		
		public function send(p_method:String,...p_args:Array):void {
			if (!_connected) { throw new ArgumentError("Send failed because the object is not connected."); }
			p_args.unshift(p_method);
			p_args.unshift("com_gskinner_utils_SWFBridge_receive");
			p_args.unshift(extID);
			lc.send.apply(lc,p_args);
		}
		
		public function close():void {
			try { lc.close(); } catch (e:*) {}
			lc = null;
			clientObj = null;
			if (!_connected) { throw new ArgumentError("Close failed because the object is not connected."); }
			_connected = false;
		}
		
		public function get id():String {
			return baseID;
		}
		
		public function get connected():Boolean {
			return _connected;
		}
		
		public function com_gskinner_utils_SWFBridge_receive(p_method:String,...p_args:Array):void {
			try {
				clientObj[p_method].apply(clientObj,p_args);
			} catch (e:*) {
				trace("SWFBridge ERROR:  "+e);
			}
		}
		
		public function com_gskinner_utils_SWFBridge_init():void {
			trace("SWFBridge (AS3) connected: "+(host?"host":"client"));
			if (host) {
				lc.send(extID,"com_gskinner_utils_SWFBridge_init");
			}
			_connected = true;
			dispatchEvent(new Event(Event.CONNECT));
		}
	}
}