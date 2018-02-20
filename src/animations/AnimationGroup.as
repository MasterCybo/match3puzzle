/**
 * Created by Artem-Home on 12.09.2016.
 */
package animations
{
	import animations.events.AnimationEvent;
	
	import aze.motion.EazeTween;
	
	import starling.display.DisplayObject;
	import starling.events.EventDispatcher;
	
	public class AnimationGroup extends EventDispatcher implements IAnimationGroup
	{
		private var _countComplete:uint;
		private var _countUpdate:uint;
		private var _tweens:Vector.<EazeTween> = new Vector.<EazeTween>();
		private var _updateEventType:String;
		private var _finishEventType:String;
		
		public function AnimationGroup()
		{
			super();
		}
		
		public function dispose():void
		{
			_tweens = null;
		}
		
		public function getProperty():AnimationProperty { return new AnimationProperty(); }
		
		public function to(target:DisplayObject, property:AnimationProperty = null):IAnimationGroup
		{
			// override me
			return this;
		}
		
		protected function addTween(tween:EazeTween):IAnimationGroup
		{
//			trace("*execute* " + this + "::addTween()");
			_tweens.push(tween);
			return this;
		}
		
		public function start(startEventType:String = null, updateEventType:String = null, finishEventType:String = null):IAnimationGroup
		{
			trace("*execute* " + this + "::start()");
			trace("_tweens.length : " + _tweens.length);
			
			_updateEventType = updateEventType;
			_finishEventType = finishEventType;
			
			dispatchAnimationEvent(startEventType);
			
			for (var i:int = 0; i < _tweens.length; i++) {
				if (_updateEventType) _tweens[i].onUpdate(onUpdate);
				_tweens[i].onComplete(onComplete).start();
			}
			return this;
		}
		
		private function onUpdate():void
		{
			if (++_countUpdate >= _tweens.length) {
				_countUpdate = 0;
				dispatchAnimationEvent(_updateEventType);
			}
		}
		
		private function onComplete():void
		{
//			trace("*execute* " + this + "::onComplete()");
//			trace("\t_countComplete : " + _countComplete);
//			trace("\t_tweens.length : " + _tweens.length);
			if (++_countComplete >= _tweens.length) {
				_tweens = null;
				completeAllTweens();
			}
		}
		
		protected function completeAllTweens():void
		{
			trace("*execute* " + this + "::completeAllTweens()");
			trace("_countComplete : " + _countComplete);
			dispatchAnimationEvent(_finishEventType);
			// override me
		}
		
		private function dispatchAnimationEvent(eventType:String):void
		{
			if (!eventType) return;
			dispatchEvent(new AnimationEvent(eventType));
		}
	}
}
