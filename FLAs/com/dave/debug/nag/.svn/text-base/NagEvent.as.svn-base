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
	import flash.events.Event;

	public class NagEvent extends Event
	{
		public static const UPDATE:String = "logEventUpdate";
		public static const LOG:String = "logEventLog";
		public static const WARN:String = "logEventWarn";
		public static const INFO:String = "logEventInfo";
		public static const ERROR:String = "logEventError";
		public static const DEBUG:String = "logEventDebug";
		
		private var _nagItem:NagItem;
		
		public function NagEvent(type:String, nagItem:NagItem, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			super(type, bubbles, cancelable);
			this._nagItem=nagItem;
		}
		
		public function get nagItem():NagItem
		{
			return this._nagItem;
		}
	}
}