/**
 * Created by Artem-Home on 05.09.2016.
 */
package utils.parsers
{
	import collections.EnumCellType;
	import collections.EnumChipType;
	
	import data.Cell;
	import data.Chip;
	import data.Grid;
	import data.builders.ChipFactory;
	
	import flash.utils.Dictionary;
	
	import ru.arslanov.core.enum.Enum;
	
	public class XMLGridParser
	{
		public static const ID_NO_CHIP:String = "-";
		public static const ID_CHIP_1:String = "a";
		public static const ID_CHIP_2:String = "b";
		public static const ID_CHIP_3:String = "c";
		public static const ID_CHIP_4:String = "d";
		public static const ID_CHIP_5:String = "e";
		public static const ID_CHIP_6:String = "f";
		
		private static var _chipsLibrary:Object = {};
		
		public function XMLGridParser()
		{
		}
		
		public static function parse(levelData:XML, grid:Grid):void
		{
//			trace("levelData :\n");
//			trace(levelData);
			
			var typeChips:Dictionary = new Dictionary();
			typeChips[ID_CHIP_1] = EnumChipType.CHIP_TYPE_1;
			typeChips[ID_CHIP_2] = EnumChipType.CHIP_TYPE_2;
			typeChips[ID_CHIP_3] = EnumChipType.CHIP_TYPE_3;
			typeChips[ID_CHIP_4] = EnumChipType.CHIP_TYPE_4;
			typeChips[ID_CHIP_5] = EnumChipType.CHIP_TYPE_5;
			typeChips[ID_CHIP_6] = EnumChipType.CHIP_TYPE_6;
			
			var chips:XMLList = levelData.chips.children();
			
//			trace("chips :\n");
//			trace(chips);
			
			var chipXml:XML;
			var chipData:Object;
			for (var i:int = 0; i < chips.length(); i++) {
				chipXml = chips[i];
				chipData = {name:chipXml.name(), type:chipXml.@type, collapsable:chipXml.@collapsable == "true", movable:chipXml.@movable == "true"};
				_chipsLibrary[chipData.name] = chipData;
			}
			
			var gridXml:XMLList = levelData.grid;
			var gridCols:uint = gridXml.@cols;
			var gridRows:uint = gridXml.@rows;
//			trace("gridXml " + gridCols + "x" + gridRows + ":\n");
//			trace(gridXml);
			
			var gridText:String = gridXml.text();
			gridText = gridText.replace(/\s/g, "");
			
//			trace("gridText.length : " + gridText.length);
//			trace("gridText :");
//			trace(gridText);

			grid.initialize(gridCols, gridRows);
			
			var cellData:String;
			var cell:Cell;
			var chip:Chip;
			var typeCell:EnumCellType;
			var numChars:uint = gridText.length;
			var index:uint;
			for (var j:int = 0; j < numChars; j+=2) {
				index = j/2;
				trace("index : " + index);
				cellData = gridText.substr(j, 2);
//				trace(j + " - " + cellData);
				typeCell = Enum.getElementByValue(cellData.charAt(0), EnumCellType) as EnumCellType;
				cell = grid.getCellAt(index);
				cell.type = typeCell;
				cell.dirty = typeCell == EnumCellType.CELL_DIRTY;
				var chipType:String = cellData.charAt(1);
				if (chipType != ID_NO_CHIP) {
					var chipParams:Object = _chipsLibrary[chipType];
					chip = ChipFactory.createChip(typeChips[chipParams.name], chipParams.collapsable, chipParams.movable);
					chip.col = int(index % grid.numCols);
					chip.row = int(index / grid.numCols);
					grid.addChip(chip);
					trace("\tcol, row : " + chip.col + ", " + chip.row);
//					trace("Create Chip: " + chip);
				}
			}
			
			_chipsLibrary = {};
		}
	}
}
