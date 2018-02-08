/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations
{
	import starling.display.DisplayObject;
	
	public interface IAnimationGroup
	{
		function addEventListener(type:String, listener:Function):void;
		function removeEventListener(type:String, listener:Function):void;
		function addTarget(target:DisplayObject, property:AnimationProperty = null):IAnimationGroup;
		function start(startEventType:String = null, updateEventType:String = null, finishEventType:String = null):IAnimationGroup;
		function getProperty():AnimationProperty;
	}
}
