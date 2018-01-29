/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import views.BaseView;
	
	public class CollapseAnimation extends AnimationGroup
	{
		public function CollapseAnimation()
		{
			super();
		}
		
		override public function addTarget(target:BaseView, property:AnimationProperty = null):IAnimationGroup
		{
			return addTween(
//					new EazeTween(target, false)
//							.to(0.1, {scaleX:1.3, scaleY:1.3}).easing(Cubic.easeOut)
//							.to(0.15, {scaleX:0, scaleY:0, alpha:0}, false).easing(Cubic.easeIn)
					new EazeTween(target, false)
							.to(0.25, {scaleX:1.3, scaleY:1.3}).easing(Cubic.easeOut)
							.to(0.25, {scaleX:0, scaleY:0, alpha:0}, false).easing(Cubic.easeIn)
			);
		}
	}
}
