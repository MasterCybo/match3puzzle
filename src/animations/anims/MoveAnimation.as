/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import starling.display.DisplayObject;
	
	public class MoveAnimation extends AnimationGroup
	{
		public function MoveAnimation()
		{
			super();
		}
		
		override public function addTarget(target:DisplayObject, property:AnimationProperty = null):IAnimationGroup
		{
			// property = {x:x, y:y}
//			return addTween(new EazeTween(target, false).to(0.15, property, false).easing(Cubic.easeOut));
			return addTween(new EazeTween(target, false).to(0.5, property.toObject(), false).easing(Cubic.easeOut));
		}
	}
}
