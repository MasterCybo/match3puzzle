/**
 * Created by Artem-Home on 19.09.2016.
 */
package data.collections
{
	import data.Chip;
	
	public class ChipsPool
	{
		private static var _free:Vector.<Chip> = new Vector.<Chip>();
		private static var _items:Vector.<Chip> = new Vector.<Chip>();
		
		public function ChipsPool()
		{
		}
		
		public static function getFree():Chip
		{
			var item:Chip;
			
			if (_free.length > 0) {
				item = _free.pop();
			} else {
				item = new Chip();
			}
			
			_items.push(item);
			return item;
		}
		
		public static function setFree(item:Chip):void
		{
			var idx:int = _items.indexOf(item);
			if (idx != -1) _items.splice(idx, 1);
			_free.push(item);
		}
	}
}
