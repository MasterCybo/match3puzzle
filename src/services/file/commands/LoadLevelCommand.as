/**
 * Created by Artem-Home on 07.09.2016.
 */
package services.file.commands
{
	import collections.LevelFile;
	
	import flash.events.Event;
	
	import ru.arslanov.flash.mvc.commands.Command;
	
	import services.file.FileService;
	
	public class LoadLevelCommand extends Command
	{
		public function LoadLevelCommand(event:Event)
		{
			super(event);
		}
		
		override public function execute():void
		{
			super.execute();
			
			var fileService:FileService = getInstance(FileService);
			fileService.load(LevelFile.LEVEL_01);
		}
	}
}
