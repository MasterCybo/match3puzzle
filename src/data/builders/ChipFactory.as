/**
 * Created by Artem-Home on 06.09.2016.
 */
package data.builders
{
	import collections.EnumChipType;
	
	import data.*;
	import data.collections.ChipsPool;
	
	import ru.arslanov.core.enum.Enum;
	
	public class ChipFactory
	{
		public function ChipFactory()
		{
		}
		
		public static function createChip(type:EnumChipType, collapsable:Boolean = true, movable:Boolean = true):Chip
		{
			trace("Create chip : " + type.value);
			var chip:Chip = ChipsPool.getFree();
			chip.type = type;
			chip.collapsable = collapsable;
			chip.movable = movable;
			
			return chip;
		}
		
		public static function createChipAnyType():Chip
		{
			var types:Vector.<EnumChipType> = Vector.<EnumChipType>(Enum.getElementsList(EnumChipType));
			var chipType:EnumChipType = types[int(Math.random() * (types.length - 1))];
			return createChip(chipType);
		}
	}
}
