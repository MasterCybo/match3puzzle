/**
 * Created by Artem-Home on 11.09.2016.
 */
package animations.events
{
	import starling.events.Event;
	
	public class AnimationEvent extends Event
	{
		public function AnimationEvent(type:String, bubbles:Boolean = true, data:Object = null)
		{
			super(type, bubbles, data);
		}
	}
}
