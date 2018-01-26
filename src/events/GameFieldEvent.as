/**
 * Created by Artem-Home on 09.09.2016.
 */
package events
{
	import flash.events.Event;
	
	public class GameFieldEvent extends Event
	{
		public static const GENERATE:String = "generate";
		
		public function GameFieldEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new GameFieldEvent(type, bubbles, cancelable);
		}
	}
}
