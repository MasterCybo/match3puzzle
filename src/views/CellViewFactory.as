/**
 * Created by Artem-Home on 06.09.2016.
 */
package views
{
	import data.Cell;
	
	import flash.display.Bitmap;
	
	import mach3.CellImage;
	import mach3.DirtyImage;
	
	public class CellViewFactory
	{
		public function CellViewFactory()
		{
		}
		
		public static function createCellView(cell:Cell):CellView
		{
			var image:Bitmap = new Bitmap(new CellImage());
			var dirty:Bitmap;
			if (cell.dirty) dirty = new Bitmap(new DirtyImage());
			var view:CellView = new CellView(cell, image, dirty);
			return view;
		}
	}
}
