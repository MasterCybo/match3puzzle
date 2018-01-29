package mediators
{
	import events.GameFieldEvent;
	
	import ru.arslanov.starling.mvc.context.IContext;
	import ru.arslanov.starling.mvc.mediators.Mediator;
	
	public class GameScreenMediator extends Mediator
	{
		public function GameScreenMediator(context:IContext)
		{
			super(context);
		}
		
		override public function initialize(displayObject:Object):void
		{
			super.initialize(displayObject);
			
			dispatchEvent(new GameFieldEvent(GameFieldEvent.GENERATE));
		}
	}
}
