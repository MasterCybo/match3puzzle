/**
 * Created by Artem-Home on 20.09.2016.
 */
package utils
{
	import data.Chip;
	import data.Grid;
	
	public class SimpleMatchFinder
	{
		public function SimpleMatchFinder()
		{
		}
		
		public static function find(grid:Grid):Vector.<Vector.<Chip>>
		{
			var matches:Vector.<Vector.<Chip>> = new Vector.<Vector.<Chip>>();
			findMatchHorizontal(matches, grid);
			findMatchVertical(matches, grid);
			return matches;
		}
		
		private static function findMatchHorizontal(matches:Vector.<Vector.<Chip>>, grid:Grid):void
		{
//			trace("*execute* Grid::findMatchHorizontal()");
			var maxCol:uint = grid.numCols - 2;
			var chips:Vector.<Chip>;
			for (var row:int = 0; row < grid.numRows; row++) {
				for (var col:int = 0; col < maxCol; col++) {
					chips = getMatchHorizontal(col, row, grid);
//					trace("\tSearch at row " + row + " => " + chips.length + " : " + vectorToString(chips));
					if (chips.length != 0) {
						if (chips.length > 2) matches.push(chips);
						col+= chips.length - 1;
					}
				}
			}
		}
		
		private static function getMatchHorizontal(startCol:uint, row:uint, grid:Grid):Vector.<Chip>
		{
			var chips:Vector.<Chip> = new Vector.<Chip>();
			
			var chip:Chip = grid.getChip(startCol, row);
			if (!chip) return chips;
			var prevChip:Chip = chip;
			
			chips.push(chip);
			
			for (var col:int = startCol + 1; col < grid.numCols; col++) {
				chip = grid.getChip(col, row);
				if (MatchChipsCondition.checkMatch(chip, prevChip)) {
					chips.push(chip);
				} else {
					return chips;
				}
				prevChip = chip;
			}
			return chips;
		}
		
		private static function findMatchVertical(matches:Vector.<Vector.<Chip>>, grid:Grid):void
		{
//			trace("*execute* Grid::findMatchVertical()");
			var maxRow:uint = grid.numRows - 2;
			var chips:Vector.<Chip>;
			for (var col:int = 0; col < grid.numCols; col++) {
//				trace("\tSearch at col " + col);
				for (var row:int = 0; row < maxRow; row++) {
//					trace("\t\tSearch at row " + row);
					chips = getMatchVertical(col, row, grid);
//					trace("\t\t\tFind " + col + " => " + chips.length + " : " + vectorToString(chips));
					if (chips.length != 0) {
						if (chips.length > 2) matches.push(chips);
						row += chips.length - 1;
					}
				}
			}
		}
		
		private static function getMatchVertical(col:uint, startRow:uint, grid:Grid):Vector.<Chip>
		{
			var chips:Vector.<Chip> = new Vector.<Chip>();
			
			var chip:Chip = grid.getChip(col, startRow);
			if (!chip) return chips;
			var prevChip:Chip = chip;
			
			chips.push(chip);
			
			for (var row:int = startRow + 1; row < grid.numRows; row++) {
				chip = grid.getChip(col, row);
				if (MatchChipsCondition.checkMatch(chip, prevChip)) {
					chips.push(chip);
				} else {
					return chips;
				}
				prevChip = chip;
			}
			return chips;
		}
	}
}
