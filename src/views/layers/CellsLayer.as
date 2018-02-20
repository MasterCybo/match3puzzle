package views.layers
{
	import collections.Dimension;
	import collections.EnumCellType;
	
	import data.Cell;
	import data.Grid;
	
	import flash.utils.Dictionary;
	
	import starling.textures.Texture;
	
	import utils.Assets;
	
	import views.BaseView;
	import views.CellView;
	
	public class CellsLayer extends BaseView
	{
		private var _grid:Grid;
		private var _cells:Dictionary = new Dictionary();
		
		public function CellsLayer()
		{
			super();
		}
		
		public function getCellView(cell:Cell):CellView { return _cells[cell]; }
		
		public function draw(grid:Grid):void
		{
			_grid = grid;
			
			var cell:Cell;
			var cellView:CellView;
			var texture:Texture = Assets.me.getTexture("cell_bg");
			
			for (var col:int = 0; col < _grid.numCols; col++) {
				for (var row:int = 0; row < _grid.numRows; row++) {
					cell = _grid.getCell(col, row);
					if (cell.type != EnumCellType.CELL_INVISIBLE) {
						cellView = getCellView(cell);
						if (!cellView) {
							cellView = new CellView(cell, texture, null);
							cellView.x = col * texture.width;
							cellView.y = row * texture.height;
							cellView.updateDebug(col, row);
							addChild(cellView);
							_cells[cell] = cellView;
							
							if (cell.type == EnumCellType.CELL_EMITTER) {
//								var emitterView:EmitterView = new EmitterView();
//								emitterView.x = cellView.centerX;
//								emitterView.y = cellView.y;
//								_emittersLayer.addChild(emitterView);
							}
						}
					}
				}
			}
		}
	}
}
