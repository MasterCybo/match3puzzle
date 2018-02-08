package utils
{
	import ru.arslanov.core.enum.Enum;
	
	public class RandomEnum
	{
		public static function getRandom(enum:Class, from:int = 0, to:int = int.MAX_VALUE):*
		{
			if (!enum) return null;
			from = Math.max(0, from);
			var elements:Vector.<Enum> = Enum.getElementsList(enum);
			to = Math.max(0, Math.min(to, elements.length - 1));
			
			var index:uint = from + int(Math.random() * to);
			return elements[index];
		}
	}
}
