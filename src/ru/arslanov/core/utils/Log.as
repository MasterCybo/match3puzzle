package ru.arslanov.core.utils
{
	import flash.external.ExternalInterface;
	import flash.system.Capabilities;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Log
	{
		
		static public var enabled:Boolean = true;
		static public var allowErrors:Boolean = true;
		static public var allowWarnings:Boolean = true;
		static public var allowText:Boolean = true;
		static public var allowDumps:Boolean = true;
		static public var allowNets:Boolean = true;


		static private var _trace:Boolean = true;
		static private var _jsConsole:Boolean = false;
		static private var _customTrace:Function;
		static private var _fileLogger:IFileLogger;

		public function Log()
		{
			
		}
		
		
		static public function set toJsConsole(value:Boolean):void
		{
			_jsConsole = value;
		}
		
		static public function set customTracer(value:Function):void
		{
			_customTrace = value;
		}
		
		static public function set toTrace(value:Boolean):void
		{
			_trace = value;
		}
		
		public static function get isAvalilableSave():Boolean
		{
			var manufactor:String = Capabilities.manufacturer.toLowerCase();
			switch (true) {
				case (manufactor.indexOf("win") != -1):
					return true;
				case (manufactor.indexOf("and") != -1):
					return true;
				default : return false;
			}
		}
		
		public static function saveToFile(fileName:String):void
		{
			if (!isAvalilableSave) return;
			
			if (Capabilities.manufacturer.toLowerCase().indexOf("win") != -1) {
				_fileLogger = new WinLogFile(fileName);
			} else {
				_fileLogger = new MobileLogFile(fileName);
			}
		}
		
		static public function traceText(...data):void
		{
			if (!allowText) return;
			send("", data);
		}
		
		static public function traceWarn(...data):void
		{
			if (!allowWarnings) return;
			send("Warning: ", data);
		}
		
		static public function traceError(...data):void
		{
			if (!allowErrors) return;
			
			send(data.join(",").indexOf("Error") == -1 ? "Error: " : "", data);
		}
		
		static public function traceNetSend(...data):void
		{
			if (!allowNets) return;
			send("NetSend: ", data);
		}
		
		static public function traceNetAnswer(...data):void
		{
			if (!allowNets) return;
			send("NetAnswer: ", data);
		}
		
		static public function traceObject(data:Object):void
		{
			if (!allowDumps) return;
			send("Object: ", Dump.object(data));
		}
		
		static public function traceArray(data:Array):void
		{
			if (!allowDumps) return;
			send("", Dump.array(data));
		}
		
		static public function traceVector(data:Object):void
		{
			if (!allowDumps) return;
			send("", Dump.array(data));
		}
		
		static public function tracePlatform():void
		{
			send("Cpu architecture : ", Capabilities.cpuArchitecture);
			send("32 Bit supports : ", Capabilities.supports32BitProcesses);
			send("64 Bit supports : ", Capabilities.supports64BitProcesses);
			send("Manufacturer : ", Capabilities.manufacturer);
			send("OS : ", Capabilities.os);
			send("Screen resolution : ", Capabilities.screenResolutionX + " x " + Capabilities.screenResolutionY);
			send("Pixel aspect ratio : ", Capabilities.pixelAspectRatio);
			send("Screen DPI : ", Capabilities.screenDPI);
			send("Touchscreen type : ", Capabilities.touchscreenType);
			send("Flash Player version : ", Capabilities.version);
		}
		
		static private function send(prefix:String, ...data):void
		{
			if (!enabled) return;
			
			var date:Date = new Date();
			var time:String = date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds() + "." + date.milliseconds + ": ";
			var str:String = prefix + data.join(", ");

			if (_trace) trace(time + str);

			if(_fileLogger) _fileLogger.write(time + str);

			if (_customTrace != null) {
				_customTrace(time + str);
			}
			
			if (_jsConsole) {
				if (ExternalInterface.available) {
					ExternalInterface.call("console.log", str);
				}
			}
			

		}
	}

}