/**
 * Created by Artem-Home on 19.09.2016.
 */
package data.collections
{
	import data.Cell;
	
	public class CellsPool
	{
		private static var _free:Vector.<Cell> = new Vector.<Cell>();
		private static var _items:Vector.<Cell> = new Vector.<Cell>();
		
		public function CellsPool()
		{
		}
		
		public static function getFree():Cell
		{
			var item:Cell;
			
			if (_free.length > 0) {
				item = _free.pop();
			} else {
				item = new Cell();
			}
			
			_items.push(item);
			return item;
		}
		
		public static function setFree(item:Cell):void
		{
			var idx:int = _items.indexOf(item);
			if (idx != -1) _items.splice(idx, 1);
			_free.push(item);
		}
	}
}
