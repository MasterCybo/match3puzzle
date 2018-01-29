/**
 * Created by Artem-Home on 05.09.2016.
 */
package data
{
	import collections.EnumChipType;
	
	import data.collections.ChipsPool;
	
	public class Chip
	{
		private var _grid:Grid;
		private var _type:EnumChipType;
		private var _collapsable:Boolean = true;
		private var _movable:Boolean = true;
		private var _col:int = -1;
		private var _row:int = -1;
		
		public function Chip()
		{
		}
		
		public function free():void
		{
			ChipsPool.setFree(this);
			_grid = null;
			_type = null;
			_col = -1;
			_row = -1;
		}
		
		public function get isFree():Boolean
		{
			return _col == -1 || _row == -1 || !_grid || !_type;
		}
		
		public function get type():EnumChipType { return _type; }
		public function set type(value:EnumChipType):void { _type = value; }
		
		public function get col():int { return _col; }
		public function set col(value:int):void { _col = value; }
		
		public function get row():int { return _row; }
		public function set row(value:int):void { _row = value; }
		
		public function get collapsable():Boolean { return _collapsable; }
		public function set collapsable(value:Boolean):void { _collapsable = value; }
		
		public function get movable():Boolean { return _movable; }
		public function set movable(value:Boolean):void { _movable = value; }
		
		public function get grid():Grid { return _grid; }
		public function set grid(value:Grid):void { _grid = value; }
		
		public function toString():String
		{
			return "[object Chip], " + _col + ":" + _row + ", type = " + _type + ", collapsable = " + _collapsable + ", movable = " + _movable;
		}
	}
}
