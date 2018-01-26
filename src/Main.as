package
{
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	[SWF(backgroundColor="#01568C", frameRate="60", width="1024", height="640")]
	public class Main extends Sprite
	{
		public function Main()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			var matchGame:AppMatchPuzzle = new AppMatchPuzzle();
			addChild(matchGame);
		}
	}
}
