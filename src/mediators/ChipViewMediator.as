/**
 * Created by Artem-Home on 07.09.2016.
 */
package mediators
{
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;
	
	import ru.arslanov.flash.mvc.context.IContextModule;
	import ru.arslanov.flash.mvc.mediators.Mediator;
	
	import views.ChipView;
	
	public class ChipViewMediator extends Mediator
	{
		
		public function ChipViewMediator(context:IContextModule)
		{
			super(context);
		}
		
		override public function initialize(displayObject:DisplayObject):void
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
