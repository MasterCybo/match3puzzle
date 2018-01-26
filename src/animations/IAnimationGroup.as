/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations
{
	import flash.events.IEventDispatcher;
	
	import views.BaseView;
	
	public interface IAnimationGroup extends IEventDispatcher
	{
		function addTarget(target:BaseView, property:AnimationProperty = null):IAnimationGroup;
		function start(startEventType:String = null, updateEventType:String = null, finishEventType:String = null):IAnimationGroup;
		function getProperty():AnimationProperty;
	}
}
