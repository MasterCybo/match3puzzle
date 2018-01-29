﻿package ru.arslanov.starling.gui.layout
{
	import flash.geom.Rectangle;
	
	import ru.arslanov.starling.display.ASprite;
	
	import starling.display.DisplayObject;
	
	/**
	 * Контейнер дисплей-объектов, в котором объекты располагаются вертикально, с регулируемым промежутком
	 * @author Artem Arslanov
	 */
	public class VBox extends ASprite
	{
		
		static public const ALIGN_LEFT:String = "left";
		static public const ALIGN_CENTER:String = "center";
		static public const ALIGN_RIGHT:String = "right";
		
		private var _space:Number = 0;
		private var _direction:int;
		private var _hAlign:String;
		
		public function VBox(space:Number = 0, direction:int = 1, horizontalAlign:String = "left")
		{
			_direction = validDirect(direction);
			_space = space;
			_hAlign = horizontalAlign;
			super();
		}
		
		public function addChildAndUpdate(child:DisplayObject):DisplayObject
		{
			var item:DisplayObject = super.addChild(child);
			update();
			return item;
		}
		
		public function addChildAtAndUpdate(child:DisplayObject, index:int):DisplayObject
		{
			var item:DisplayObject = super.addChildAt(child, index);
			update();
			return item;
		}
		
		public function removeChildAndUpdate(child:DisplayObject):DisplayObject
		{
			if (!contains(child)) return null;
			var item:DisplayObject = super.removeChild(child);
			update();
			return item;
		}
		
		public function removeChildAtAndUpdate(index:int):DisplayObject
		{
			if (getChildAt(index) && !contains(getChildAt(index))) return null;
			var item:DisplayObject = super.removeChildAt(index);
			update();
			return item;
		}
		
		public function get space():Number
		{
			return _space;
		}
		
		public function set space(value:Number):void
		{
			if (space == value) return;
			_space = value;
			update();
		}
		
		public function get direction():int
		{
			return _direction;
		}
		
		public function set direction(value:int):void
		{
			if (direction == value) return;
			_direction = validDirect(value);
			update();
		}
		
		public function hAlign(align:String):void
		{
			_hAlign = align;
			update();
		}
		
		public function update(alignWidth:Boolean = false):void
		{
			var rect:Rectangle;
			var item:DisplayObject;
			var yp:Number = getFirstY();
			var maxWidth:Number = 0;
			var len:uint = numChildren;
			
			for (var i:int = 0; i < len; i++) {
				item = getChildAt(i);
				rect = item.getBounds(item);
				item.y = yp - rect.y;
				yp += direction * ( item.height + space );
				
				maxWidth = Math.max(item.width, maxWidth);
			} // for
			
			for (i = 0; i < len; i++) {
				item = getChildAt(i);

				if (alignWidth && !("wordWrap" in item)) {
					item.width = maxWidth;
				}

				rect = item.getBounds(item);
				switch (_hAlign) {
					case ALIGN_RIGHT:
						item.x = maxWidth - rect.width;
						break;
					case ALIGN_CENTER:
						item.x = Math.round(( maxWidth - rect.width ) / 2);
						break;
					default:
						item.x = 0;
				}

			} // for
			
			item = null;
			rect = null;
		}
		
		protected function validDirect(value:int):int
		{
			return Math.min(Math.max(-1, value), 1);
		}
		
		protected function getFirstY():Number
		{
			return ( numChildren == 0 ) || ( direction >= 0 ) ? 0 : direction * getChildAt(0).height;
		}
	}

}