package
{
	import configs.CommandsConfig;
	import configs.MediatorsConfig;
	import configs.ModelsConfig;
	import configs.ServicesConfig;
	
	import ru.arslanov.starling.mvc.context.Context;
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.extensions.FeathersBundle;
	
	import starling.display.Sprite;
	import starling.events.Event;
	
	import utils.Assets;
	
	public class StarlingRoot extends Sprite
	{
		private var _context:IContext;
		
		public function StarlingRoot()
		{
			super();
			stage ? init() : addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		public function init(event:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Assets.me.init();
			
			var gameScreen:GameScreen = new GameScreen();
			addChild(gameScreen);
			
			_context = new Context()
					.install(FeathersBundle)
					.configure(ModelsConfig,
							ServicesConfig,
							CommandsConfig,
							MediatorsConfig,
							gameScreen);
			
			
		}
		
	}
}
