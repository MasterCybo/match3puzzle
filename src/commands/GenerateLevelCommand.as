/**
 * Created by Artem-Home on 09.09.2016.
 */
package commands
{
	import collections.EnumCellType;
	import collections.EnumChipType;
	
	import data.Cell;
	import data.Chip;
	
	import data.builders.ChipFactory;
	import data.Grid;
	
	import events.LevelEvent;
	
	import flash.events.Event;
	
	import ru.arslanov.core.enum.Enum;
	import ru.arslanov.flash.mvc.commands.Command;
	
	public class GenerateLevelCommand extends Command
	{
		public function GenerateLevelCommand(event:Event)
		{
			super(event);
		}
		
		override public function execute():void
		{
			super.execute();
			
			var typeCells:Vector.<Enum> = Enum.getElementsList(EnumCellType);
			var typeChips:Vector.<Enum> = Enum.getElementsList(EnumChipType);
			
			var grid:Grid = getInstance(Grid);
			grid.initialize(9, 9);
			
			var cell:Cell;
			var chip:Chip;
			for (var row:int = 0; row < 9; row++) {
				for (var col:int = 0; col < 9; col++) {
					cell = grid.getCell(col, row);
					var indexCellType:uint = int(1 + Math.random() * (typeCells.length - 2));
					cell.type = typeCells[indexCellType] as EnumCellType;
					var indexChipType:uint = int(Math.random() * (typeChips.length - 1));
					chip = ChipFactory.createChip(typeChips[indexChipType] as EnumChipType);
					chip.col = col;
					chip.row = row;
					grid.addChip(chip);
				}
			}
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_CREATED));
		}
	}
}
