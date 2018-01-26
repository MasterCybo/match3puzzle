/**
 * Created by Artem-Home on 07.09.2016.
 */
package events
{
	import flash.events.Event;
	
	public class LevelEvent extends Event
	{
		public static const LEVEL_CREATED:String = "gridCreated";
		
		public function LevelEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new LevelEvent(type, bubbles, cancelable);
		}
	}
}
