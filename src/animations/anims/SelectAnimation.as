/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import starling.display.DisplayObject;
	
	public class SelectAnimation extends AnimationGroup
	{
		public function SelectAnimation()
		{
			super();
		}
		
		override public function to(target:DisplayObject, property:AnimationProperty = null):IAnimationGroup
		{
			return addTween(
					new EazeTween(target, false)
							.to(0.15, {scaleX:1.2, scaleY:1.2}, false).easing(Cubic.easeOut));
		}
	}
}
