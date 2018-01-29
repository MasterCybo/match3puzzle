/**
 * Created by Artem-Home on 07.09.2016.
 */
package services.file
{
	import flash.events.EventDispatcher;
	
	import services.file.events.FileServiceEvent;
	
	import utils.load.FileLoader;
	import utils.load.events.LoaderEvent;
	
	public class FileService extends EventDispatcher
	{
		private var _loader:FileLoader = new FileLoader();
		
		public function FileService()
		{
			super();
		}
		
		public function get data():* { return _loader.data; }
		
		public function load(file:String):void
		{
			_loader.addEventListener(LoaderEvent.LOAD_ERROR, loaderHandler);
			_loader.addEventListener(LoaderEvent.LOAD_COMPLETE, loaderHandler);
			_loader.load(file);
		}
		
		private function loaderHandler(event:LoaderEvent):void
		{
			_loader.removeEventListener(LoaderEvent.LOAD_ERROR, loaderHandler);
			_loader.removeEventListener(LoaderEvent.LOAD_COMPLETE, loaderHandler);
			
			switch (event.type) {
				case LoaderEvent.LOAD_COMPLETE:
					dispatchEvent(new FileServiceEvent(FileServiceEvent.LOAD_COMPLETE));
					break;
				case LoaderEvent.LOAD_ERROR:
					trace(event.message);
					break;
			}
		}
	}
}
