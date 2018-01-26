/**
 * Created by Artem-Home on 06.09.2016.
 */
package data.builders
{
	import data.*;
	import collections.EnumCellType;
	
	import data.collections.CellsPool;
	
	public class CellFactory
	{
		public function CellFactory()
		{
		}
		
		public static function createCell(type:EnumCellType):Cell
		{
			var cell:Cell = CellsPool.getFree();
			cell.type = type;
			return cell;
		}
	}
}
