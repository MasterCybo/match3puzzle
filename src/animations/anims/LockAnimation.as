/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import starling.display.DisplayObject;
	
	public class LockAnimation extends AnimationGroup
	{
		public function LockAnimation()
		{
			super();
		}
		
		override public function to(target:DisplayObject, property:AnimationProperty = null):IAnimationGroup
		{
			var duration:Number = 0.05;
			var duration05:Number = duration / 2;
			var amplitude:Number = 3;
			var center:Number = target.x;
			
			new EazeTween(target)
					.to(duration05, {x:center + amplitude}, false).easing(Cubic.easeOut)
					.to(duration, {x:center - amplitude}, false).easing(Cubic.easeInOut)
					.to(duration, {x:center + 0.5 * amplitude}, false).easing(Cubic.easeInOut)
					.to(duration, {x:center - 0.5 * amplitude}, false).easing(Cubic.easeInOut)
					.to(duration05, {x:center}, false).easing(Cubic.easeIn);
			return this;
			// TODO не известный баг, анимация не запускается по start()
			/*
			return addTween(
					new EazeTween(target, false)
							.to(duration05, {x:center + amplitude}, false).easing(Cubic.easeOut)
							.to(duration, {x:center - amplitude}, false).easing(Cubic.easeInOut)
							.to(duration, {x:center + 0.5 * amplitude}, false).easing(Cubic.easeInOut)
							.to(duration, {x:center - 0.5 * amplitude}, false).easing(Cubic.easeInOut)
							.to(duration05, {x:center}, false).easing(Cubic.easeIn)
			);
			*/
		}
	}
}
