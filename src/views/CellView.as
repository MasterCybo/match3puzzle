/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Cell;
	
	import starling.display.Image;
	import starling.text.TextField;
	import starling.text.TextFieldAutoSize;
	import starling.textures.Texture;
	
	public class CellView extends BaseView
	{
		private var _cell:Cell;
		private var _imageTexture:Texture;
		private var _dirtyTexture:Texture;
		private var _image:Image;
		private var _dirty:Image;
		private var _offsetCenterX:Number = 0;
		private var _offsetCenterY:Number = 0;
		
		private var _tf:TextField;
		
		public function CellView(cell:Cell, image:Texture, dirtyImage:Texture = null)
		{
			super();
			
			_cell = cell;
			_imageTexture = image;
			_dirtyTexture = dirtyImage;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			addChild(_image = new Image(_imageTexture));
			
			if (_dirtyTexture) {
				_dirty = new Image(_dirtyTexture);
				addChild(_dirty);
			}
			
			_offsetCenterX = int(_image.width / 2);
			_offsetCenterY = int(_image.height / 2);
			
			_tf = new TextField(10, 10, "");
			_tf.autoSize = TextFieldAutoSize.BOTH_DIRECTIONS;
			addChild(_tf);
		}
		
		override public function dispose():void
		{
			super.dispose();
			_dirty = null;
			_cell = null;
		}
		
		public function get model():Cell { return _cell; }
		
		public function get offsetCenterX():Number { return _offsetCenterX; }
		public function get offsetCenterY():Number { return _offsetCenterY; }
		
		public function get centerX():Number { return x + _offsetCenterX; }
		public function get centerY():Number { return y + _offsetCenterY; }
		
		public function clearDirty():void
		{
			if (_dirty) removeChild(_dirty);
		}
		
		public function updateDebug(col:uint, row:uint):void
		{
			if (_tf) _tf.text = col + ":" + row;
		}
	}
}
