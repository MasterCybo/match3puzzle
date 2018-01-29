package configs
{
	import ru.arslanov.starling.mvc.config.Config;
	import ru.arslanov.starling.mvc.context.IContext;
	
	import services.file.FileService;
	
	public class ServicesConfig extends Config
	{
		public function ServicesConfig(context:IContext)
		{
			super(context);
		}
		
		override public function configure():void
		{
			super.configure();
			
			injector.map(FileService).toValue(new FileService());
		}
	}
}
