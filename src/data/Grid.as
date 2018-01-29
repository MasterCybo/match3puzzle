/**
 * Created by Artem-Home on 05.09.2016.
 */
package data
{
	import collections.EnumCellType;
	
	import data.builders.CellFactory;
	import data.builders.ChipFactory;
	
	import utils.SimpleMatchFinder;
	
	public class Grid
	{
		private var _numCols:uint;
		private var _numRows:uint;
		private var _numCells:uint;
		private var _cells:Vector.<Cell>;
		private var _chips:Vector.<Chip>;
		
		public function Grid()
		{
		}
		
		public function initialize(cols:uint, rows:uint):void
		{
			_numCols = cols;
			_numRows = rows;
			_numCells = _numCols * _numRows;
			
			_chips = new Vector.<Chip>(_numCells);
			_cells = new Vector.<Cell>();
			
			var cell:Cell;
			for (var row:int = 0; row < _numRows; row++) {
				for (var col:int = 0; col < _numCols; col++) {
					cell = CellFactory.createCell(EnumCellType.CELL_NORMAL);
					cell.grid = this;
					_cells.push(cell);
				}
			}
		}
		
		public function get numCols():uint { return _numCols; }
		public function get numRows():uint { return _numRows; }
		
		private function getIndex(col:int, row:int):uint { return row * _numCols + col; }
		
		public function getCell(col:int, row:int):Cell
		{
			if (col < 0 || row < 0) throw new RangeError("Coordinates of out : " + col + "<" + _numCols + ", " + row + "<" + _numRows);
			var index:uint = getIndex(col, row);
			if (index >= _numCells) throw new RangeError("Coordinates of out : " + col + "<" + _numCols + ", " + row + "<" + _numRows);
			return _cells[index];
		}
		
		public function getCellAt(index:uint):Cell
		{
			if (index >= _numCells) throw new RangeError("Index of out : " + index + "<" + _numCells);
			return _cells[index];
		}
		
		public function getChip(col:int, row:int):Chip
		{
			if (col < 0 || row < 0) throw new RangeError("Coordinates of out : " + col + "<" + _numCols + ", " + row + "<" + _numRows);
			var index:uint = getIndex(col, row);
			if (index >= _numCells) throw new RangeError("Coordinates of out : " + col + "<" + _numCols + ", " + row + "<" + _numRows);
			return _chips[index];
		}
		
		public function addChip(chip:Chip):Chip
		{
			var index:uint = getIndex(chip.col, chip.row);
			if (index >= _numCells) throw new RangeError("Coordinates of out : " + chip.col + "<" + _numCols + ", " + chip.row + "<" + _numRows);
			chip.grid = this;
			_chips[index] = chip;
			return chip;
		}
		
		public function removeChip(chip:Chip):Chip
		{
			trace("*execute* Grid::removeChip()");
			if (!chip) throw new ArgumentError("Argument can not be null!");
			
			trace("chip : " + chip);
			
			var index:uint = getIndex(chip.col, chip.row);
			if (index >= _numCells) throw new RangeError("Coordinates of out : " + chip.col + "<" + _numCols + ", " + chip.row + "<" + _numRows);
			_chips[index] = null;
			chip.free();
			return chip;
		}
		
		public function removeChipAt(col:uint, row:uint):Chip
		{
			var chip:Chip = getChip(col, row);
			return removeChip(chip);
		}
		
		public function makeSwap(col1:uint, row1:uint, col2:uint, row2:uint):void
		{
//			trace("*execute* Grid::makeSwap()");
			var cell1:Cell = getCell(col1, row1);
			var cell2:Cell = getCell(col2, row2);
			
			if (cell1.type == EnumCellType.CELL_INVISIBLE || cell2.type == EnumCellType.CELL_INVISIBLE) return;
			
			var index1:uint = getIndex(col1, row1);
			var index2:uint = getIndex(col2, row2);
			var chip1:Chip = getChip(col1, row1);
			var chip2:Chip = getChip(col2, row2);
			
//			trace("\tChip 1 : " + chip1);
//			trace("\tChip 2 : " + chip2);
			
			if (chip1) {
				chip1.col = col2;
				chip1.row = row2;
			}
			
			if (chip2) {
				chip2.col = col1;
				chip2.row = row1;
			}
			_chips[index1] = chip2;
			_chips[index2] = chip1;
			
//			trace("\tSwap...");
//			trace("\tChip 1 : " + chip1);
//			trace("\tChip 2 : " + chip2);
		}
		
		public function findAndRemoveMatches():Vector.<Vector.<Chip>>
		{
//			AdvMatchFinder.find(this);
//			var matches:Vector.<Vector.<Chip>>;
			var matches:Vector.<Vector.<Chip>> = SimpleMatchFinder.find(this);
			
			trace("matches :\n" + matches);
			/*
			if (matches.length > 0) {
				removeMatches(matches);
//				spawnNewChips();
			}
			*/
			return matches;
		}
		
		private function spawnNewChips():void
		{
			var cell:Cell;
			var chip:Chip;
			for (var row:int = 0; row < _numRows; row++) {
				for (var col:int = 0; col < _numCols; col++) {
					cell = getCell(col, row);
					if (cell.type == EnumCellType.CELL_EMITTER) {
						chip = getChip(col, row);
						if (!chip) {
							chip = ChipFactory.createChipAnyType();
							chip.col = col;
							chip.row = row;
							addChip(chip);
						}
					}
				}
			}
			
			findAndRemoveMatches();
		}
		
		private function removeMatches(matchesList:Vector.<Vector.<Chip>>):void
		{
			var chips:Vector.<Chip>;
			var chip:Chip;
			var i:int;
			var j:int;
			for (i = 0; i < matchesList.length; i++) {
				chips = matchesList[i];
				for (j = 0; j < chips.length; j++) {
					chip = chips[j];
					if (!chip.isFree) {
						var col:uint = chip.col;
						var row:uint = chip.row;
						removeChip(chip);
						dropDownAbove(col, row);
					}
				}
			}
			
			findAndRemoveMatches();
		}
		
		private function dropDownAbove(col:uint, row:uint):void
		{
			var chip:Chip;
			var chipAbove:Chip;
			for (var i:int = row; i >= 0; i--) {
				chip = getChip(col, i);
				if (!chip) {
					chipAbove = getChipAbove(col, i);
					if (chipAbove) {
						var colAbove:uint = chipAbove.col;
						var rowAbove:uint = chipAbove.row;
						makeSwap(col, i, chipAbove.col, chipAbove.row);
						if (colAbove != col) dropDownAbove(colAbove, rowAbove);
					} else {
//						break;
					}
				}
			}
		}
		
		private function getChipAbove(col:uint, row:uint):Chip
		{
//			trace("*execute* Grid::getChipAbove()");
			if (row - 1 < 0) return null;
			var chip:Chip = getChip(col, row - 1); // сверху
//			var chip:Chip = getChipByCell(col, row - 1); // сверху
			if (chip && !chip.movable) {
				if (col - 1 >= 0) {
					chip = getChip(col - 1, row - 1); // слева по-диагонали
					if (!chip || (chip && !chip.movable)) {
						if (col + 1 < _numCols) {
							chip = getChip(col + 1, row - 1); // справа по-диагонали
							if (chip && !chip.movable) chip = null;
						}
					}
				}
			}
//			trace("chip : " + chip);
			return chip;
		}
		
		private function getChipByCell(col:uint, row:uint):Chip
		{
			var cell:Cell = getCell(col, row);
			if (cell.type == EnumCellType.CELL_INVISIBLE) {
				if (col - 1 >= 0) {
					cell = getCell(col - 1, row);
					
					if (cell.type == EnumCellType.CELL_INVISIBLE) {
						if (col + 1 < _numCols) {
							cell = getCell(col + 1, row);
							
							if (cell.type == EnumCellType.CELL_INVISIBLE) {
								return null;
							} else {
								return getChip(col + 1, row);
							}
						}
					} else {
						return getChip(col - 1, row);
					}
				}
			}
			return getChip(col, row);
		}
		
		private function vectorToString(chips:Vector.<Chip>):String
		{
			var str:String = "";
			for (var i:int = 0; i < chips.length; i++) {
				var chip:Chip = chips[i];
				str += chip.type.value + ", ";
			}
			return str.substr(0, str.length - 2);
		}
	}
}
