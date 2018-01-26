/**
 * Created by Artem-Home on 05.09.2016.
 */
package utils.load
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	import utils.load.events.LoaderEvent;
	
	public class FileLoader extends EventDispatcher
	{
		private var _loader:URLLoader = new URLLoader();
		private var _request:URLRequest = new URLRequest();
		
		public function FileLoader()
		{
		}
		
		public function load(file:String):void
		{
			_request.url = file;
			
			addListeners();
			_loader.load(_request);
		}
		
		public function get data():XML { return XML(_loader.data); }
		
		private function addListeners():void
		{
			_loader.addEventListener(Event.COMPLETE, onLoadComplete);
			_loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function removeListeners():void
		{
			_loader.removeEventListener(Event.COMPLETE, onLoadComplete);
			_loader.removeEventListener(IOErrorEvent.IO_ERROR, onIOError);
			_loader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
		}
		
		private function onLoadComplete(event:Event):void
		{
			removeListeners();
			dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_COMPLETE));
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			removeListeners();
			dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_ERROR, event.text));
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void
		{
			removeListeners();
			dispatchEvent(new LoaderEvent(LoaderEvent.LOAD_ERROR, event.text));
		}
	}
}
