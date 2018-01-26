/**
 * Created by Artem-Home on 05.09.2016.
 */
package data
{
	import collections.EnumCellType;
	
	import data.collections.CellsPool;
	
	public class Cell
	{
		private var _type:EnumCellType;
		private var _grid:Grid;
		private var _dirty:Boolean;
		
		public function Cell()
		{
		}
		
		public function free():void
		{
			CellsPool.setFree(this);
			_type = null;
			_grid = null;
		}
		
		public function get type():EnumCellType { return _type; }
		public function set type(value:EnumCellType):void { _type = value; }
		
		public function get grid():Grid { return _grid; }
		public function set grid(value:Grid):void { _grid = value; }
		
		public function get dirty():Boolean { return _dirty; }
		public function set dirty(value:Boolean):void { _dirty = value; }
		
		public function toString():String
		{
			return "[object Cell], type = " + _type + ", dirty = " + _dirty;
		}
	}
}
