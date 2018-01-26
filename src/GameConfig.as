/**
 * Created by Artem-Home on 07.09.2016.
 */
package
{
	import commands.GenerateLevelCommand;
	
	import data.GameData;
	import data.Grid;
	
	import events.GameFieldEvent;
	
	import mediators.ChipViewMediator;
	
	import mediators.GridViewMediator;
	
	import ru.arslanov.flash.mvc.Config;
	import ru.arslanov.flash.mvc.context.IContextModule;
	
	import services.file.FileService;
	import services.file.commands.LoadLevelCommand;
	import services.file.commands.ParseLevelCommand;
	import services.file.events.FileServiceEvent;
	
	import views.ChipView;
	
	import views.GridView;
	
	public class GameConfig extends Config
	{
		public function GameConfig(context:IContextModule)
		{
			super(context);
		}
		
		override public function initialize():void
		{
			super.initialize();
			
			addSingleton(FileService, new FileService(context));
			addSingleton(Grid, new Grid());
			addSingleton(GameData, new GameData());
			
			addMediator(GridViewMediator, GridView);
			addMediator(ChipViewMediator, ChipView);
			
			mapCommand(GameFieldEvent.GENERATE, GenerateLevelCommand);
			mapCommand(FileServiceEvent.START_LOADING, LoadLevelCommand);
			mapCommand(FileServiceEvent.LOAD_COMPLETE, ParseLevelCommand);
		}
	}
}
