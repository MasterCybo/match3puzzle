/**
 * Created by Artem-Home on 20.09.2016.
 */
package utils
{
	import data.Chip;
	import data.Grid;
	
	import flash.utils.Dictionary;
	
	public class AdvMatchFinder
	{
		private static var _matched:Dictionary = new Dictionary();
		
		public function AdvMatchFinder()
		{
		}
		
		public static function find(grid:Grid):Vector.<Vector.<Chip>>
		{
			_matched = new Dictionary();
			var matchList:Vector.<Vector.<Chip>> = new Vector.<Vector.<Chip>>();
			
			for (var row:int = 0; row < grid.numRows; row++) {
				for (var col:int = 0; col < grid.numCols; col++) {
					var chip:Chip = grid.getChip(col, row);
					if (_matched[chip] == undefined) {
						var matches:Vector.<Chip> = new Vector.<Chip>();
						findFor(chip, matches, grid);
						if (matches.length >= 3) {
							matchList.push(matches);
						}
					}
				}
			}
			_matched = null;
			return matchList;
		}
		
		private static function findFor(chip:Chip, matches:Vector.<Chip>, grid:Grid):void
		{
			var matchChip:Chip = getNeighbors(chip, grid);
			
			if (matchChip && _matched[matchChip] == undefined) {
				if (matchChip.type == chip.type) {
					matches.push(matchChip);
					_matched[chip] = true;
					findFor(matchChip, matches, grid);
				} else {
					delete _matched[chip];
				}
			}
		}
		
		private static function getNeighbors(chip:Chip, grid:Grid):Chip
		{
			var nextCol:int = chip.col + 1; // справа
			var nextRow:int = chip.row;
			var nextChip:Chip;
			if (nextCol < grid.numCols) {
				nextChip = grid.getChip(nextCol, nextRow);
				if (chip.type == nextChip.type) {
					return nextChip;
				}
			}
			
			nextCol = chip.col - 1; // слева
			if (nextCol >= 0) {
				nextChip = grid.getChip(nextCol, nextRow);
				if (chip.type == nextChip.type) {
					return nextChip;
				}
			}
			
			nextRow = chip.row - 1; // сверху
			nextCol = chip.col;
			if (nextRow >= 0) {
				nextChip = grid.getChip(nextCol, nextRow);
				if (chip.type == nextChip.type) {
					return nextChip;
				}
			}
			
			nextRow = chip.row + 1; // снизу
			if (nextRow < grid.numRows) {
				nextChip = grid.getChip(nextCol, nextRow);
				if (chip.type == nextChip.type) {
					return nextChip;
				}
			}
			
			return null;
		}
	}
}
