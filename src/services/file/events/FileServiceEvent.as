/**
 * Created by Artem-Home on 07.09.2016.
 */
package services.file.events
{
	import flash.events.Event;
	
	public class FileServiceEvent extends Event
	{
		public static const START_LOADING:String = "startLoading";
		public static const LOAD_COMPLETE:String = "loadComplete";
		
		public function FileServiceEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new FileServiceEvent(type, bubbles, cancelable);
		}
	}
}
