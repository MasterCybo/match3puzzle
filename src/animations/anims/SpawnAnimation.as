/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations.anims
{
	import animations.*;
	import aze.motion.EazeTween;
	import aze.motion.easing.Cubic;
	
	import views.BaseView;
	
	public class SpawnAnimation extends AnimationGroup
	{
		private var _tween:EazeTween;
		
		public function SpawnAnimation()
		{
			super();
		}
		
		override public function addTarget(target:BaseView, property:AnimationProperty = null):IAnimationGroup
		{
			/*
			if (!_tween) {
				_tween = new EazeTween(target, false);
			} else {
				_tween.chain(target);
			}
			
			_tween.from(0.2, {scaleX:0.5, scaleY:0.5, alpha:0}).easing(Cubic.easeIn)
					.to(0.2, {scaleX:1.2, scaleY:1.2}, false).easing(Cubic.easeOut)
					.to(0.15, {scaleX:1, scaleY:1}, false).easing(Cubic.easeIn).onComplete(onComplete);
			*/
			/*
			new EazeTween(target)
					.from(0.2, {scaleX:0.5, scaleY:0.5, alpha:0}).easing(Cubic.easeIn)
					.to(0.2, {scaleX:1.2, scaleY:1.2}, false).easing(Cubic.easeOut)
					.to(0.15, {scaleX:1, scaleY:1}, false).easing(Cubic.easeIn).onComplete(completeAllTweens);
			
			return this;
			*/
			
			return addTween(new EazeTween(target, false)
					.from(0.5, {scaleX:0.2, scaleY:0.2, alpha:0}).easing(Cubic.easeIn)
					.to(0.5, {scaleX:1.1, scaleY:1.1}, false).easing(Cubic.easeOut)
					.to(0.5, {scaleX:1, scaleY:1}, false).easing(Cubic.easeOut)
			)
			
		}
	}
}
