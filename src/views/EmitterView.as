/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import flash.display.Bitmap;
	
	import mach3.EmitterImage;
	
	public class EmitterView extends BaseView
	{
		private var _image:Bitmap;
		
		private var _pivotX:Number = 0;
		private var _pivotY:Number = 0;
		
		public function EmitterView()
		{
			super();
			_image = new Bitmap(new EmitterImage());
			addChild(_image);
			
			pivotX = int(_image.width / 2);
		}
		
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
	}
}
