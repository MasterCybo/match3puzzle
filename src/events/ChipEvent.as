/**
 * Created by Artem-Home on 07.09.2016.
 */
package events
{
	import starling.events.Event;
	
	public class ChipEvent extends Event
	{
		public static const CHIP_MOVED:String = "chipMoved";
		public static const CHIP_POSITION_UPDATED:String = "chipPositionUpdated";
		
		public function ChipEvent(type:String, bubbles:Boolean = false, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
