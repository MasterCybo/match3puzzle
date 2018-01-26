/**
 * Created by Artem-Home on 07.09.2016.
 */
package animations
{
	import animations.anims.CollapseAnimation;
	import animations.anims.DeselectionAnimation;
	import animations.anims.LockAnimation;
	import animations.anims.MoveAnimation;
	import animations.anims.SelectionAnimation;
	import animations.anims.SpawnAnimation;
	
	public class AnimationFactory implements IAnimationFactory
	{
		private static var _instance:IAnimationFactory;
		
		public static function get me():IAnimationFactory
		{
			if (!_instance) _instance = new AnimationFactory(new PrivateKey());
			return _instance;
		}
		
		public function AnimationFactory(key:PrivateKey)
		{
			if (!key) throw new Error("Error: Instantiation failed: Use Animator.me instead of new.");
		}
		
		
		public function makeLocked():IAnimationGroup { return new LockAnimation(); }
		public function makeMoveTo():IAnimationGroup { return new MoveAnimation(); }
		public function makeSelection():IAnimationGroup { return new SelectionAnimation(); }
		public function makeDeselection():IAnimationGroup { return new DeselectionAnimation(); }
		public function makeCollapse():IAnimationGroup { return new CollapseAnimation(); }
		public function makeSpawn():IAnimationGroup
		{
			return new SpawnAnimation();
//			eaze(target).from(0.5, {scaleX:0.5, scaleY:0.5, alpha:1});//.to(0.2, {scaleX:1.5, scaleY:1.5, alpha:0}, false).easing(Cubic.easeOut);
		}
	}
}
internal class PrivateKey {}