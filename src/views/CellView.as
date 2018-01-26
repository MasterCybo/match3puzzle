/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Cell;
	
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class CellView extends BaseView
	{
		private var _cell:Cell;
		private var _dirty:Bitmap;
		private var _offsetCenterX:Number = 0;
		private var _offsetCenterY:Number = 0;
		
		private var _tf:TextField;
		
		public function CellView(cell:Cell, image:Bitmap, dirtyImage:Bitmap = null)
		{
			_cell = cell;
			super();
			
			addChild(image);

			if (dirtyImage) {
				_dirty = dirtyImage;
				addChild(_dirty);
			}
			
			_offsetCenterX = int(image.width / 2);
			_offsetCenterY = int(image.height / 2);
			
			_tf = new TextField();
			_tf.selectable = false;
			_tf.mouseEnabled = false;
			_tf.autoSize = TextFieldAutoSize.LEFT;
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
			if (!_dirty) return;
			removeChild(_dirty);
		}
		
		public function updateDebug(col:uint, row:uint):void
		{
			_tf.text = col + ":" + row;
		}
	}
}
