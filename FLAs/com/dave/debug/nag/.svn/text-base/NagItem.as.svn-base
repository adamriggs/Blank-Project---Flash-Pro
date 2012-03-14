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
	public class NagItem
	{
		public static const INFO:String = "info";
		public static const WARN:String = "warn";
		public static const ERROR:String = "error";
		public static const LOG:String = "log";
		public static const DEBUG:String = "debug";
		
		protected static const FIELD_SEPERATOR: String = " :: ";	
		
		private var _type:String;
		private var _info:Array;
		private var _time:String
		
		public function NagItem(type:String, ...rest):void
		{
			this._type=type;
			this._info=rest;
			this._time=this.getCurrentTime();
		}
		
		public function get type():String
		{
			return this._type;
		}
		
		public function get info():Array
		{
			return this._info;
		}
		
		public function get dateStamp():String
		{
			return this._time;
		}
		
		private function getCurrentTime ():String
			    {
		    		var currentDate: Date = new Date();

					var currentTime: String = 	"time "
												+ timeToValidString(currentDate.getHours()) 
												+ ":" 
												+ timeToValidString(currentDate.getMinutes()) 
												+ ":" 
												+ timeToValidString(currentDate.getSeconds()) 
												+ "." 
												+ timeToValidString(currentDate.getMilliseconds()) + FIELD_SEPERATOR;
					return currentTime;
			    }

				/**
				 * Creates a valid time value
				 * @param 	number     	Hour, minute or second
				 * @return 	string 		A valid hour, minute or second
				 */

				private function timeToValidString(timeValue: Number):String
			    {
			        return timeValue > 9 ? timeValue.toString() : "0" + timeValue.toString();
			    }
	}
}