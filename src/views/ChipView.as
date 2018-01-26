/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Chip;
	
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class ChipView extends BaseView
	{
		private var _chip:Chip;
		private var _image:Bitmap;
		private var _pivotX:Number = 0;
		private var _pivotY:Number = 0;
		
		private var _tf:TextField;
		
		public function ChipView(chip:Chip, image:Bitmap)
		{
			_chip = chip;
			super();
			
			_image = image;
			addChild(_image);
			
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.LEFT;
			_tf.text = _chip.col + ":" + _chip.row;
			addChild(_tf);
			
			pivotX = int(_image.width / 2);
			pivotY = int(_image.height / 2);
			
			mouseEnabled = true;
		}
		
		override protected function initialize():void
		{
			super.initialize();
		}
		
		override public function dispose():void
		{
			super.dispose();
			_chip = null;
			_image = null;
		}
		
		public function get model():Chip { return _chip; }
		
		public function get pivotX():Number { return _pivotX; }
		public function set pivotX(value:Number):void
		{
			if (value == _pivotX) return;
			_pivotX = value;
			applyPivotPoint();
		}
		
		public function get pivotY():Number { return _pivotY; }
		public function set pivotY(value:Number):void
		{
			if (value == _pivotY) return;
			_pivotY = value;
			applyPivotPoint();
		}
		
		private function applyPivotPoint():void
		{
			_image.x = -_pivotX;
			_image.y = -_pivotY;
		}
		
		public function debugUpdate():void
		{
			_tf.text = _chip.col + ":" + _chip.row;
		}
		
		public function debugCollapse():void
		{
			var bounds:Rectangle = getBounds(this);
			graphics.lineStyle(1, 0xFF0000);
			graphics.beginFill(0xFF0000, 0.5);
			graphics.drawRect(bounds.x, bounds.y, bounds.width, bounds.height);
			graphics.endFill();
		}
	}
}
