package ru.arslanov.flash.mvc.mediators
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import ru.arslanov.flash.mvc.context.IContextModule;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class MediatorMap
	{
		private var _context:IContextModule;
		private var _map:Dictionary = new Dictionary();
		private var _mediators:Dictionary = new Dictionary();

		public function MediatorMap(context:IContextModule)
		{
			_context = context;
			_context.stage.addEventListener(Event.ADDED, onStageAdded);
			_context.stage.addEventListener(Event.REMOVED, onStageRemoved);
		}

		public function addMediator(mediator:Class, displayObject:Class):void
		{
			if (_map[displayObject] != undefined) {
				trace("WARNING! MediateManager.mapMediator : " + mediator + " already addMediator " + displayObject);
				return;
			}
			_map[displayObject] = mediator;
		}

		public function removeMediator(mediator:Class):void
		{
			for each (var med:Class in _map) {
				if (med == mediator) {
					delete _map[mediator];
					break;
				}
			}
		}

		private function onStageAdded(event:Event):void
		{
			createMediator(event.target as DisplayObject);
		}

		private function onStageRemoved(event:Event):void
		{
			destroyMediator(event.target as DisplayObject);
		}
		
		private function createMediator(object:DisplayObject):void
		{
			var displayObject:Class = object["constructor"];
			var mediatorClass:Class = _map[displayObject];
			
			if (!mediatorClass) return;
			
			var mediator:IMediator = new mediatorClass(_context);
			_mediators[displayObject] = mediator;
			mediator.initialize(object);
		}
		
		private function destroyMediator(object:DisplayObject):void
		{
			var displayObject:Class = object["constructor"];
			var mediator:IMediator = _mediators[displayObject];
			
			if (!mediator) return;
			
			mediator.destroy();
			delete _mediators[displayObject];
		}
	}
}