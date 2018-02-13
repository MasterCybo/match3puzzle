/**
 * Created by Artem-Home on 07.09.2016.
 */
package views.layers
{
	import animations.AnimationFactory;
	
	import events.ChipEvent;
	
	import views.BaseView;
	import views.ChipView;
	
	public class ChipsLayer extends BaseView
	{
		private var _isLocked:Boolean;
		private var _offsetX:int;
		private var _offsetY:int;
		private var _beganX:int;
		private var _beganY:int;
		private var _deltaMove:int;
		private var _isHorizontal:Boolean;
		private var _isDropped:Boolean;
		
		public function ChipsLayer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			addEventListener(ChipEvent.CHIP_SELECTED, chipEventHandler);
			addEventListener(ChipEvent.CHIP_SELECTED, chipEventHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(ChipEvent.CHIP_SELECTED, chipEventHandler);
			super.dispose();
		}
		
		private function chipEventHandler(event:ChipEvent):void
		{
			var chipView:ChipView = event.target as ChipView;
			trace("chipView: " + chipView);
//			trace("\ttouch.target: " + touch.target);
			/*
			switch (touch.phase) {
				case TouchPhase.BEGAN:
					_isDropped = false;
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
					if (!_isDropped) {
						var deltaX:int = Math.abs(touch.globalX - _beganX);
						var deltaY:int = Math.abs(touch.globalY - _beganY);
						var chipSize:int;
						
						if (deltaX > 0) {
							if (deltaX > deltaY) {
								_isHorizontal = true;
								chipSize = chipView.width;
							}
						}
						if (deltaY > 0) {
							if (deltaY > deltaX) {
								_isHorizontal = false;
								chipSize = chipView.height;
							}
						}
						
						_deltaMove = Math.max(deltaX, deltaY);
						
						chipView.x = int(!_isHorizontal) * _beganX + int(_isHorizontal) * (touch.globalX - _offsetX);
						chipView.y = int(_isHorizontal) * _beganY + int(!_isHorizontal) * (touch.globalY - _offsetY);
						chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_MOVED, true));
						
						if (_deltaMove > chipSize / 2) {
							dropChip(chipView);
						}
					}
					break;
				case TouchPhase.ENDED:
					dropChip(chipView);
					break;
			}
			*/
		}
		
		private function dropChip(chipView:ChipView):void
		{
			_isDropped = true;
			
			AnimationFactory.me.makeDeselection().addTarget(chipView).start();
			if (!_isLocked) {
				chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_DROPPED, true));
			}
			_isLocked = false;
		}
	}
}
