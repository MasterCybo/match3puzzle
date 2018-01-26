/**
 * Created by Artem-Home on 07.09.2016.
 */
package services.file.commands
{
	import data.Grid;
	
	import events.LevelEvent;
	
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.commands.Command;
	
	import services.file.FileService;
	
	import utils.parsers.XMLGridParser;
	
	public class ParseLevelCommand extends Command
	{
		public function ParseLevelCommand(event:Event)
		{
			super(event);
		}
		
		override public function execute():void
		{
			super.execute();
			
			var fileService:FileService = getInstance(FileService);
			var grid:Grid = getInstance(Grid);
			
			XMLGridParser.parse(fileService.data, grid);
			
			dispatchEvent(new LevelEvent(LevelEvent.LEVEL_CREATED));
		}
	}
}
