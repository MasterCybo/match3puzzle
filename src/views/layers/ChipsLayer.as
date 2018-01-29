/**
 * Created by Artem-Home on 07.09.2016.
 */
package views.layers
{
	import animations.AnimationFactory;
	
	import flash.events.MouseEvent;
	
	import views.BaseView;
	import views.ChipView;
	
	public class ChipsLayer extends BaseView
	{
		private var _isLocked:Boolean;
		
		public function ChipsLayer()
		{
			super();
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_MOVE, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			super.dispose();
		}
		
		private function mouseHandler(event:MouseEvent):void
		{
			var chipView:ChipView = event.target as ChipView;
			if (chipView) {
				switch (event.type) {
					case MouseEvent.MOUSE_DOWN:
						trace("@ MOUSE press on Chip : " + chipView.model.col + ":" + chipView.model.row);
						if(chipView.model.movable) {
							AnimationFactory.me.makeSelection().addTarget(chipView).start();
							chipView.parent.addChild(chipView);
//							chipView.startDrag();
						} else {
							_isLocked = true;
							AnimationFactory.me.makeLocked().addTarget(chipView).start();
						}
						break;
					case MouseEvent.MOUSE_MOVE:
						break;
					case MouseEvent.MOUSE_UP:
						AnimationFactory.me.makeDeselection().addTarget(chipView).start();
//						if (!_isLocked) {
//							chipView.stopDrag();
//							chipView.dispatchEvent(new ChipEvent(ChipEvent.CHIP_MOVED, true));
//						}
						_isLocked = false;
						break;
				}
			}
		}
	}
}
