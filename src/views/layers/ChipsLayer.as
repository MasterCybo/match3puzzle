/**
 * Created by Artem-Home on 07.09.2016.
 */
package views.layers
{
	import animations.AnimationFactory;
	
	import events.ChipEvent;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	import views.BaseView;
	import views.ChipView;
	
	public class ChipsLayer extends BaseView
	{
		private var _isLocked:Boolean;
		private var _offsetX:int;
		private var _offsetY:int;
		private var _beganX:int;
		private var _beganY:int;
		private var _isHorizontal:Boolean;
		
		public function ChipsLayer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, touchHandler);
			super.dispose();
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0];
			var chipView:ChipView = touch.target as ChipView;
			
			switch (touch.phase) {
				case TouchPhase.BEGAN:
					if(chipView.model.movable) {
						AnimationFactory.me.makeSelection().addTarget(chipView).start();
						chipView.parent.addChild(chipView);
						_offsetX = touch.globalX - chipView.x;
						_offsetY = touch.globalY - chipView.y;
						_beganX = chipView.x;
						_beganY = chipView.y;
					} else {
						_isLocked = true;
						AnimationFactory.me.makeLocked().addTarget(chipView).start();
					}
					break;
				case TouchPhase.MOVED:
					var deltaX:int = Math.abs(touch.globalX - _beganX);
					var deltaY:int = Math.abs(touch.globalY - _beganY);
					
					if (deltaX > 0) {
						if (deltaX > deltaY) _isHorizontal = true;
					}
					if (deltaY > 0) {
						if (deltaY > deltaX) _isHorizontal = false;
					}
					
					chipView.x = int(!_isHorizontal) * _beganX + int(_isHorizontal) * (touch.globalX - _offsetX);
					chipView.y = int(_isHorizontal) * _beganY + int(!_isHorizontal) * (touch.globalY - _offsetY);
					chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_MOVED, true));
					break;
				case TouchPhase.ENDED:
					AnimationFactory.me.makeDeselection().addTarget(chipView).start();
					if (!_isLocked) {
						chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_DROPPED, true));
					}
					_isLocked = false;
					break;
			}
		}
	}
}
