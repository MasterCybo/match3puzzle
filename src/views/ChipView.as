/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Chip;
	
	import events.ChipEvent;
	
	import flash.geom.Rectangle;
	
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	
	public class ChipView extends BaseView
	{
		private var _chip:Chip;
		private var _texture:Texture;
		private var _image:BaseImage;
		private var _pivotX:Number = 0;
		private var _pivotY:Number = 0;
		
		private var _tf:TextField;
		
		public function ChipView(chip:Chip, texture:Texture)
		{
			super();
			
			_chip = chip;
			_texture = texture;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_image = new BaseImage(_texture);
			addChild(_image);
			
			_tf = new TextField(10, 10, "", new TextFormat("Verdana", 34));
			_tf.touchable = false;
			_tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_tf.text = _chip.col + ":" + _chip.row;
			addChild(_tf);
			
			updatePosition();
			
			pivotX = int(_image.width / 2);
			pivotY = int(_image.height / 2);
			
			addEventListener(TouchEvent.TOUCH, touchHandler);
		}
		
		override public function dispose():void
		{
			removeEventListener(TouchEvent.TOUCH, touchHandler);
			super.dispose();
			_chip = null;
		}
		
		private function touchHandler(event:TouchEvent):void
		{
			event.stopPropagation();
			event.stopImmediatePropagation();
			
			var touch:Touch = event.getTouch(_image);
			
			if (!touch || (touch.phase != TouchPhase.ENDED && touch.phase != TouchPhase.BEGAN)) return;
			
			var isSelf:Boolean = stage.hitTest(touch.getLocation(stage)) == _image;
			
			trace("isSelf: " + isSelf);
			
			switch (touch.phase) {
				case TouchPhase.BEGAN:
//					animatePress();
					trace("Dispatch ChipEvent.CHIP_SELECTED");
					dispatchEvent(new ChipEvent(ChipEvent.CHIP_SELECTED));
					break;
				case TouchPhase.ENDED:
					if (isSelf) {
//						animateRelease().onComplete(onReleaseComplete);
					} else {
//						animateRelease();
					}
					break;
			}


//			if (event.target == this) return;

//			var touch:Touch = event.getTouch(this);
//			if (touch) {
//				trace("touch.target: " + touch.target);
//				dispatchEvent(new TouchEvent(event.type, Vector.<Touch>([touch])));
//			}
		}
		
		public function get model():Chip { return _chip; }
		
		public function debugUpdate():void
		{
			_tf.text = _chip.col + ":" + _chip.row;
			updatePosition();
		}
		
		private function updatePosition():void
		{
			_tf.x = int((_image.width - _tf.width) / 2);
			_tf.y = int((_image.height - _tf.height) / 2);
		}
		
		public function debugCollapse():void
		{
			var bounds:Rectangle = getBounds(this);
//			graphics.lineStyle(1, 0xFF0000);
//			graphics.beginFill(0xFF0000, 0.5);
//			graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
//			graphics.endFill();
		}
	}
}
