/**
 * Created by Artem-Home on 07.09.2016.
 */
package mediators
{
	import ru.arslanov.starling.mvc.context.Context;
	import ru.arslanov.starling.mvc.mediators.Mediator;
	
	import views.ChipView;
	
	public class ChipViewMediator extends Mediator
	{
		
		public function ChipViewMediator(context:Context)
		{
			super(context);
		}
		
		override public function initialize(displayObject:Object):void
		{
			super.initialize(displayObject);
			
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
		public function get view():ChipView { return getView() as ChipView; }
	}
}
