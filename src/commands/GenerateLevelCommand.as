/**
 * Created by Artem-Home on 09.09.2016.
 */
package commands
{
	import collections.EnumCellType;
	import collections.EnumChipType;
	
	import data.Cell;
	import data.Chip;
	import data.Grid;
	import data.builders.ChipFactory;
	
	import events.LevelEvent;
	
	import flash.events.Event;
	
	import ru.arslanov.core.enum.Enum;
	import ru.arslanov.starling.mvc.commands.Command;
	import ru.arslanov.starling.mvc.context.IContext;
	
	public class GenerateLevelCommand extends Command
	{
		public function GenerateLevelCommand(context:IContext, event:Event)
		{
			super(context, event);
		}
		
		override public function execute():void
		{
			super.execute();
			
			var typeChips:Vector.<Enum> = Enum.getElementsList(EnumChipType);
			
			var grid:Grid = injector.getOf(Grid);
			grid.initialize(5, 5);
			
			var cell:Cell;
			var chip:Chip;
			for (var row:int = 0; row < grid.numRows; row++) {
				for (var col:int = 0; col < grid.numCols; col++) {
					cell = grid.getCell(col, row);
					cell.type = EnumCellType.CELL_NORMAL;
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
