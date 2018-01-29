package configs
{
	import commands.GenerateLevelCommand;
	
	import events.GameFieldEvent;
	
	import ru.arslanov.starling.mvc.config.Config;
	import ru.arslanov.starling.mvc.context.IContext;
	
	import services.file.commands.LoadLevelCommand;
	import services.file.commands.ParseLevelCommand;
	import services.file.events.FileServiceEvent;
	
	public class CommandsConfig extends Config
	{
		public function CommandsConfig(context:IContext)
		{
			super(context);
		}
		
		override public function configure():void
		{
			super.configure();
			
			commandMap.map(GameFieldEvent.GENERATE).toCommand(GenerateLevelCommand);
			commandMap.map(FileServiceEvent.START_LOADING).toCommand(LoadLevelCommand);
			commandMap.map(FileServiceEvent.LOAD_COMPLETE).toCommand(ParseLevelCommand);
		}
	}
}
