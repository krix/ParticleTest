package
{
	import org.flixel.*;
	
	[SWF(width="640", height="480", backgroundColor="#000000")]
	//[Frame(factoryClass="Preloader")]

	public class ParticleTest extends FlxGame
	{
		public function ParticleTest():void
		{
			super(320, 240, TestState, 2, 60, 60);
			forceDebugger = true;
		}
	}
}
