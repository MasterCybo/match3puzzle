/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import views.BaseView;
	
	public class SelectionAnimation extends AnimationGroup
	{
		public function SelectionAnimation()
		{
			super();
		}
		
		override public function addTarget(target:BaseView, property:AnimationProperty = null):IAnimationGroup
		{
			return addTween(
					new EazeTween(target, false)
							.to(0.15, {scaleX:1.2, scaleY:1.2}, false).easing(Cubic.easeOut));
		}
	}
}
