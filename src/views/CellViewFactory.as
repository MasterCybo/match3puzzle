/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Cell;
	
	import utils.Assets;
	
	public class CellViewFactory
	{
		public function CellViewFactory()
		{
		}
		
		public static function createCellView(cell:Cell):CellView
		{
			var view:CellView = new CellView(cell, Assets.me.getTexture("cell_bg_01"), null);
			return view;
		}
	}
}
