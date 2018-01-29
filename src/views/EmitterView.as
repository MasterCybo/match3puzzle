/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import starling.display.Image;
	import starling.textures.Texture;
	
	public class EmitterView extends BaseView
	{
		private var _texture:Texture;
		private var _image:Image;
		
		private var _pivotX:Number = 0;
		private var _pivotY:Number = 0;
		
		public function EmitterView(texture:Texture)
		{
			super();
			_texture = texture;
		}
		
		override protected function initialize():void
		{
			super.initialize();
			
			_image = new Image(_texture);
			addChild(_image);
			
			pivotX = int(_image.width / 2);
		}
		/*
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
		*/
	}
}
