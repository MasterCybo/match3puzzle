/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import animations.FAnimate;
	
	import data.Chip;
	
	import events.ChipEvent;
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import starling.display.DisplayObject;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.text.TextFormat;
	import starling.textures.Texture;
	
	public class ChipView extends BaseView
	{
		private var _chip:Chip;
		private var _texture:Texture;
		private var _image:BaseImage;
		private var _selected:Boolean;
		
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
			
			alpha = 0.5;
			
			addChild(_image = new BaseImage(_texture));
			
			_tf = new TextField(10, 10, "", new TextFormat("Verdana", 34));
			_tf.touchable = false;
			_tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			_tf.text = _chip.col + ":" + _chip.row;
			addChild(_tf);
			
			arrange();
			
			pivotX = int(_image.width / 2);
			pivotY = int(_image.height / 2);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_chip = null;
		}
		
		override public function hitTest(localPoint:Point):DisplayObject
		{
			return _image.getBounds(this).containsPoint(localPoint) ? this : null;
		}
		
		public function get model():Chip { return _chip; }
		
		public function get selected():Boolean {return _selected;}
		public function set selected(value:Boolean):void
		{
			if (value == _selected) return;
			_selected = value;
			
			if (_selected) {
				FAnimate.me.selection().to(this).start();
				dispatchEvent(new ChipEvent(ChipEvent.CHIP_SELECTED));
			} else {
				FAnimate.me.deselection().to(this).start();
				dispatchEvent(new ChipEvent(ChipEvent.CHIP_DESELECTED));
			}
		}
		
		public function debugUpdate():void
		{
			_tf.text = _chip.col + ":" + _chip.row;
			arrange();
		}
		
		private function arrange():void
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
