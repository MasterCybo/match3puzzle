/**
 * Created by Artem-Home on 11.09.2016.
 */
package animations.events
{
	import flash.events.Event;
	
	public class AnimationEvent extends Event
	{
		public function AnimationEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		override public function clone():Event
		{
			return new AnimationEvent(type, bubbles, cancelable);
		}
	}
}
