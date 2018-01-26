/**
 * Copyright (c) 2015 Artem Arslanov. All rights reserved.
 */
package ru.arslanov.flash.mvc.context
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;

	import ru.arslanov.flash.mvc.Repository;
	import ru.arslanov.flash.mvc.commands.Commander;
	import ru.arslanov.flash.mvc.mediators.MediatorMap;


	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class ContextModule implements IContextModule
	{
		private var _commander:Commander = Commander.me;
		private var _repository:Repository = Repository.me;

		private var _mediatorMap:MediatorMap;
		private var _contextView:DisplayObjectContainer;

		public function ContextModule(moduleViewContext:DisplayObjectContainer)
		{
			_contextView = moduleViewContext;
			_mediatorMap = new MediatorMap(this);
		}

		public function get stage():Stage { return _contextView.stage; }
		public function get contextView():DisplayObjectContainer { return _contextView; }

		public function addConfig(configClass:Class):IContextModule
		{
			new configClass(this).initialize();
			return this;
		}
		
		public function addSingleton(type:Class, instance:Object):void
		{
			trace(this + " : Singleton " + instance + " as " + type);
			_repository.addInstance(type, instance);
		}
		
		public function removeSingleton(type:Class, objectDestructor:String = null):void
		{
			_repository.removeInstance(type, objectDestructor);
		}
		
		public function addMediator(mediator:Class, viewClass:Class):void
		{
			_mediatorMap.addMediator(mediator, viewClass);
		}
		
		public function removeMediator(mediator:Class):void
		{
			_mediatorMap.removeMediator(mediator);
		}
		
		public function mapCommand(eventType:String, commandClass:Class):void
		{
			_commander.mapCommand(eventType, commandClass);
		}
		
		public function unmapCommand(eventType:String):void
		{
			_commander.unmapCommand(eventType);
		}

		public function dispatchEvent(event:Event, verbose:Boolean = false):Boolean
		{
			return _commander.dispatchEvent(event);
		}

		public function addEventListener(eventType:String, listener:Function):void
		{
			_commander.addEventListener(eventType, listener);
		}

		public function removeEventListener(eventType:String, listener:Function = null):void
		{
			_commander.removeEventListener(eventType, listener);
		}

		public function getInstance(type:Class):*
		{
			return _repository.getInstance(type);
		}

		public function hasInstance(type:Class):Boolean
		{
			return _repository.hasInstance(type);
		}
	}
}
