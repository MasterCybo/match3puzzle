/**
 * Created by Artem-Home on 07.09.2016.
 */
package animations
{
	import animations.anims.CollapseAnimation;
	import animations.anims.DeselectAnimation;
	import animations.anims.LockAnimation;
	import animations.anims.MoveAnimation;
	import animations.anims.SelectAnimation;
	import animations.anims.SpawnAnimation;
	
	public class FAnimate implements IFAnimate
	{
		private static var _instance:IFAnimate;
		
		public static function get me():IFAnimate
		{
			if (!_instance) _instance = new FAnimate(new PrivateKey());
			return _instance;
		}
		
		public function FAnimate(key:PrivateKey)
		{
			if (!key) throw new Error("Error: Instantiation failed: Use Animator.me instead of new.");
		}
		
		
		public function lock():IAnimationGroup { return new LockAnimation(); }
		public function move():IAnimationGroup { return new MoveAnimation(); }
		public function selection():IAnimationGroup { return new SelectAnimation(); }
		public function deselection():IAnimationGroup { return new DeselectAnimation(); }
		public function collapse():IAnimationGroup { return new CollapseAnimation(); }
		public function spawn():IAnimationGroup
		{
			return new SpawnAnimation();
//			eaze(target).from(0.5, {scaleX:0.5, scaleY:0.5, alpha:1});//.to(0.2, {scaleX:1.5, scaleY:1.5, alpha:0}, false).easing(Cubic.easeOut);
		}
	}
}
internal class PrivateKey {}