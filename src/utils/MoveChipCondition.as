/**
 * Created by Artem-Home on 08.09.2016.
 */
package utils
{
	import collections.EnumCellType;
	
	import data.Cell;
	import data.Chip;
	import data.Grid;
	
	public class MoveChipCondition
	{
		public function MoveChipCondition()
		{
		}
		
		public static function checkMove(dragChip:Chip, newCol:int, newRow:int):Boolean
		{
			var deltaCols:int = dragChip.col - newCol;
			if (Math.abs(deltaCols) > 1) return false;
			
			var deltaRows:int = dragChip.row - newRow;
			if (Math.abs(deltaRows) > 1) return false;
			
			var grid:Grid = dragChip.grid;
			if ((newCol >= grid.numCols) || (newRow >= grid.numRows)) return false;
			
			var dropCell:Cell = grid.getCell(newCol, newRow);
			if (dropCell.type == EnumCellType.CELL_INVISIBLE) return false;
			
			var dropChip:Chip = grid.getChip(newCol, newRow);
			if (!dropChip || !dropChip.movable) return false;
			
			var moveUp:Boolean = deltaRows == 1;
			var moveDown:Boolean = deltaRows == -1;
			var moveLeft:Boolean = deltaCols == 1;
			var moveRight:Boolean = deltaCols == -1;
			
			if ((moveUp || moveDown) && !moveLeft && !moveRight) return true;
			if ((moveLeft || moveRight) && !moveUp && !moveDown) return true;
			return false;
		}
	}
}
