/**
 * Created by Artem-Home on 08.09.2016.
 */
package animations
{
	public interface IFAnimate
	{
		function lock():IAnimationGroup;
		function move():IAnimationGroup;
		function selection():IAnimationGroup;
		function deselection():IAnimationGroup;
		function collapse():IAnimationGroup;
		function spawn():IAnimationGroup;
	}
}
