/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import views.BaseView;
	
	public class DeselectionAnimation extends AnimationGroup
	{
		public function DeselectionAnimation()
		{
			super();
		}
		
		override public function addTarget(target:BaseView, property:AnimationProperty = null):IAnimationGroup
		{
			return addTween(
					new EazeTween(target, false)
							.to(0.1, {scaleX:1, scaleY:1}, false).easing(Cubic.easeIn));
		}
	}
}
