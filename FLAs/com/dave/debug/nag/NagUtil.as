 /*
 Copyright (c) 2006-2008  P.J. Onori (email: somerandomdude@somerandomdude.net)

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/

package com.somerandomdude.tres.debug.nag
{
	import com.somerandomdude.tres.debug.Console;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.events.EventDispatcher
	import com.serialization.json.JSON;
	
	public class NagUtil extends EventDispatcher
	{
		protected var _log:Array = new Array();
		protected var _errorLog:Array = new Array();
		protected var _warnLog:Array = new Array();
		protected var _infoLog:Array = new Array();
		protected var _debugLog:Array = new Array();
		
		protected var _firebugConsole:Boolean;
		protected var _traceEnabled:Boolean;
		protected var _dispatchEvents:Boolean;
		
		protected var _enabled:Boolean;
		
		private var _purgeInt:uint;
		private var _purgeTimer:Timer;
	
		public function log(...rest):void
		{
			var l:NagItem = new NagItem(NagType.LOG, rest);
			this._log.push(l);
			if(_firebugConsole) Console.log("log", l.dateStamp, rest);
			if(_traceEnabled) trace("LOG: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.LOG, l));
		}
		
		public function warn(...rest):void
		{
			var l:NagItem = new NagItem(NagType.WARN, rest);
			this._log.push(l);
			this._warnLog.push(l);
			if(_firebugConsole) Console.log("warn", l.dateStamp, rest);
			if(_traceEnabled) trace("WARNING: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.WARN, l));
		}
		
		public function info(...rest):void
		{
			var l:NagItem = new NagItem(NagType.INFO, rest);
			this._log.push(l);
			this._infoLog.push(l);
			if(_firebugConsole) Console.log("info", l.dateStamp, rest);
			if(_traceEnabled) trace("INFO: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.INFO, l));
		}
		
		public function error(...rest):void
		{
			var l:NagItem = new NagItem(NagType.ERROR, rest);
			this._log.push(l);
			this._errorLog.push(l);
			if(_firebugConsole) Console.log("error", l.dateStamp, rest);
			if(_traceEnabled) trace("ERROR: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.ERROR, l));
		}
		
		public function debug(...rest):void
		{
			var l:NagItem = new NagItem(NagType.DEBUG, rest);
			this._log.push(l);
			this._debugLog.push(l);
			if(_firebugConsole) Console.log("debug", l.dateStamp, rest);
			if(_traceEnabled) trace("DEBUG: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.DEBUG, l));
		}
		
		public function custom(type:String, ...rest):void
		{
			var l:NagItem = new NagItem(type, rest);
			this._log.push(l);
			this._debugLog.push(l);
			if(_firebugConsole) Console.log("debug", l.dateStamp, rest);
			if(_traceEnabled) trace("DEBUG: ", l.dateStamp, rest);
			if(_dispatchEvents) this.dispatchEvent(new NagEvent(NagEvent.DEBUG, l));
		}
		
		public function getLogsByType(type:String):Array
		{
			var log:Array = new Array();
			for(var i:int=0; i<this._log.length; i++)
			{
				if(this._log[i].type==type) log.push(this._log[i]);
			}
			return log;
		}

		public function get fullLog():Array
		{
			return this._log;
		}
		
		public function get warnLog():Array
		{
			return this._warnLog;
		}
		
		public function get infoLog():Array
		{
			return this._infoLog;
		}
		
		public function get errorLog():Array
		{
			return this._errorLog;
		}
		
		public function get debugLog():Array
		{
			return this._debugLog;
		}
		
		public function set enabled(value:Boolean):void
		{
			
		}
		
		public function set dispatchEventsEnabled(value:Boolean):void
		{
			this._dispatchEvents=value;
		}
		
		public function set firebugConsoleEnabled(value:Boolean):void
		{
			this._firebugConsole=value;
		}
		
		public function set traceEnabled(value:Boolean):void
		{
			this._traceEnabled=value;
		}
		
		public function set purgeInterval(value:int):void
		{
			if(_purgeTimer) 
			{
				if(value==-1)
				{
					_purgeTimer.reset();
				}
				_purgeTimer.reset();
				_purgeTimer.delay=value;
				_purgeTimer.start();
				return;
			}
			
			this._purgeInt=value;
			_purgeTimer = new Timer(value);
			_purgeTimer.addEventListener(TimerEvent.TIMER, purge);
			_purgeTimer.start();
		}
		
		public function get purgeInterval():int
		{
			return (!_purgeTimer)?-1:_purgeTimer.delay;	
		}
		
		public function purge(event:TimerEvent=null):void
		{
			_log = new Array();
			_errorLog = new Array();
			_warnLog = new Array();
			_infoLog = new Array();
			_debugLog = new Array();
		}
		
		public function toJSON():String
		{
			var str:String;
			var obj:Object;
			var log:Array = new Array();
			for(var i:int=0; i<_log.length; i++)
			{
				obj = new Object();
				obj.dateStamp = _log[i].dateStamp;
				obj.type = _log[i].type;	
				obj.info = _log[i].info;	
				log.push(obj);
			}
			
			try
			{
				str = JSON.serialize(log);
			} catch(e:Error) {
				str="";
			}
			return str;	
		}
	}
}