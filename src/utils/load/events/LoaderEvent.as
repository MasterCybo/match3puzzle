/**
 * Created by Artem-Home on 05.09.2016.
 */
package utils.load.events
{
	import flash.events.Event;
	
	public class LoaderEvent extends Event
	{
		public static const LOAD_COMPLETE:String = "loadComplete";
		public static const LOAD_ERROR:String = "loadError";
		
		private var _message:String;
		
		public function LoaderEvent(type:String, message:String = "", bubbles:Boolean = false, cancelable:Boolean = false)
		{
			_message = message;
			super(type, bubbles, cancelable);
		}
		
		public function get message():String { return _message; }
		
		override public function clone():Event
		{
			return new LoaderEvent(type, message, bubbles, cancelable);
		}
	}
}
