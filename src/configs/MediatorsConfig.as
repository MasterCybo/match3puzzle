package configs
{
	import mediators.ChipViewMediator;
	import mediators.GameScreenMediator;
	import mediators.BoardViewMediator;
	
	import ru.arslanov.starling.mvc.config.Config;
	import ru.arslanov.starling.mvc.context.IContext;
	
	import views.ChipView;
	import views.BoardView;
	
	public class MediatorsConfig extends Config
	{
		public function MediatorsConfig(context:IContext)
		{
			super(context);
		}
		
		override public function configure():void
		{
			super.configure();
			
			mediatorMap.map(GameScreen).toMediator(GameScreenMediator);
			mediatorMap.map(BoardView).toMediator(BoardViewMediator);
			mediatorMap.map(ChipView).toMediator(ChipViewMediator);
		}
	}
}
