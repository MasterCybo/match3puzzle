package configs
{
	import mediators.ChipViewMediator;
	import mediators.GameScreenMediator;
	import mediators.GridViewMediator;
	
	import ru.arslanov.starling.mvc.config.Config;
	import ru.arslanov.starling.mvc.context.IContext;
	
	import views.ChipView;
	import views.GridView;
	
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
			mediatorMap.map(GridView).toMediator(GridViewMediator);
			mediatorMap.map(ChipView).toMediator(ChipViewMediator);
		}
	}
}
