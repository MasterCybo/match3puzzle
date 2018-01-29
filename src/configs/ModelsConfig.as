package configs
{
	import data.GameData;
	import data.Grid;
	
	import ru.arslanov.starling.mvc.config.Config;
	import ru.arslanov.starling.mvc.context.IContext;
	
	public class ModelsConfig extends Config
	{
		public function ModelsConfig(context:IContext)
		{
			super(context);
		}
		
		override public function configure():void
		{
			super.configure();
			
			injector.map(Grid).asSingleton(Grid);
			injector.map(GameData).asSingleton(GameData);
		}
	}
}
