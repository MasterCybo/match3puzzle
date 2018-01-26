package ru.arslanov.flash.mvc
{
	import flash.utils.Dictionary;
	
	import ru.arslanov.flash.mvc.context.IInstanceAccessor;
	
	/**
	 * ...
	 * @author Artem Arslanov
	 */
	public class Repository implements IInstanceAccessor
	{
		static private var _instance:Repository;
		
		static public function get me():Repository
		{
			if (!_instance) _instance = new Repository(new SingletonKey());
			return _instance;
		}
		
		
		private var _map:Dictionary = new Dictionary();
		private var _types:Vector.<Class> = new Vector.<Class>();
		
		public function Repository(key:SingletonKey) {}
		
		public function getInstance(type:Class):* { return _map[type]; }
		public function hasInstance(type:Class):Boolean { return getInstance(type) != null; }

		public function addInstance(type:Class, entity:*):* {
			if (getInstance(type)) {
				trace("WARNING Repository!!! Instance [" + type + "] already exists!");
				return entity;
			}
			_map[type] = entity;
			_types.push(type);
			return entity;
		}
		
		public function removeInstance(type:Class, objectDestructor:String = null):Boolean {
			var entity:Object = getInstance(type);
			if (!entity) return false;
			var idx:int = _types.indexOf(type);
			if (idx != -1) _types.splice(idx, 1);
			delete _map[type];
			if (objectDestructor) entity[objectDestructor];
			return true;
		}
		
		public function removeAllInstances(destructMethod:String = null):Boolean {
			for (var i:int = 0; i < _types.length;i++ ) {
				removeInstance(_types[i], destructMethod);
			}
			_types.length = 0;
			return true;
		}
		
		public function getAllTypes():Vector.<Class> { return _types; }
	}

}

internal class SingletonKey {
	public function SingletonKey() {}
}