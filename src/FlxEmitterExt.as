package  
{
	import org.flixel.*;
	
	/**
	 * Extended FlxEmitter that emits particles in a circle (instead of a square).
	 * It also provides a new function setMotion to control particle behavior even more.
	 * This was inspired by the way Chevy Ray Johnston implemented his particle emitter in Flashpunk.
	 * @author Dirk Bunk
	 */
	public class FlxEmitterExt extends FlxEmitter 
	{		
		/**
		 * 	Launch Direction.
		 */
		public var angle:Number;
		
		/**
		 * 	Distance to travel.
		 */
		public var distance:Number;
		
		/**
		 * 	Random amount to add to the particle's direction.
		 */
		public var angleRange:Number;
		
		/**
		 * 	Random amount to add to the particle's distance.
		 */
		public var distanceRange:Number;
		
		/**
		 * 	Random amount to add to the particle's duration.
		 */
		public var lifespanRange:Number;
		
		/**
		 * Creates a new <code>FlxEmitterExt</code> object at a specific position.
		 * Does NOT automatically generate or attach particles!
		 * 
		 * @param	X		The X position of the emitter.
		 * @param	Y		The Y position of the emitter.
		 * @param	Size	Optional, specifies a maximum capacity for this emitter.
		 */
		public function FlxEmitterExt(X:Number=0, Y:Number=0, Size:Number=0) 
		{
			super(X, Y, Size);
			
			//set defaults
			setMotion(0, 0, 0.5, 360, 100, 1.5);
		}
		
		/**
		 * Defines the motion range for this emitter.
		 * @param	angle			Launch Direction.
		 * @param	distance		Distance to travel.
		 * @param	lifespan		Particle duration.
		 * @param	angleRange		Random amount to add to the particle's direction.
		 * @param	distanceRange	Random amount to add to the particle's distance.
		 * @param	lifespanRange	Random amount to add to the particle's duration.
		 */
		public function setMotion(angle:Number, distance:Number, lifespan:Number, angleRange:Number = 0, distanceRange:Number = 0, lifespanRange:Number = 0):void
		{
			this.angle = angle * 0.017453293;
			this.distance = distance;
			this.lifespan = lifespan;
			this.angleRange = angleRange * 0.017453293;
			this.distanceRange = distanceRange;
			this.lifespanRange = lifespanRange;
		}
		
		/**
		 * Defines the motion range for a specific particle.
		 * @param   particle		The Particle to set the motion for
		 * @param	angle			Launch Direction.
		 * @param	distance		Distance to travel.
		 * @param	lifespan		Particle duration.
		 * @param	angleRange		Random amount to add to the particle's direction.
		 * @param	distanceRange	Random amount to add to the particle's distance.
		 * @param	lifespanRange	Random amount to add to the particle's duration.
		 */
		private function setParticleMotion(particle:FlxParticle, angle:Number, distance:Number, lifespan:Number, angleRange:Number = 0, distanceRange:Number = 0, lifespanRange:Number = 0):void
		{			
			//set particle direction and speed
			var a:Number = angle + FlxG.random() * angleRange;
			var d:Number = distance + FlxG.random() * distanceRange;
				
			particle.velocity.x = Math.cos(a) * d;
			particle.velocity.y = Math.sin(a) * d;
			particle.lifespan = lifespan + FlxG.random() * lifespanRange;
		}
		
		/**
		 * Call this function to start emitting particles.
		 * 
		 * @param	Explode		Whether the particles should all burst out at once.
		 * @param	Lifespan	Unused parameter due to class override. Use setMotion to set things like a particle's lifespan.
		 * @param	Frequency	Ignored if Explode is set to true. Frequency is how often to emit a particle. 0 = never emit, 0.1 = 1 particle every 0.1 seconds, 5 = 1 particle every 5 seconds.
		 * @param	Quantity	How many particles to launch. 0 = "all of the particles".
		 */
		override public function start(Explode:Boolean = true, Lifespan:Number = 0, Frequency:Number = 0.1, Quantity:uint = 0):void
		{
			super.start(Explode, this.lifespan, Frequency, Quantity);
		}
		
		/**
		 * This function can be used both internally and externally to emit the next particle.
		 */
		override public function emitParticle():void
		{
			//recycle a particle to emit
			var particle:FlxParticle = recycle(FlxParticle) as FlxParticle;
			particle.elasticity = bounce;
			particle.reset(x - (particle.width >> 1) + FlxG.random() * width, y - (particle.height >> 1) + FlxG.random() * height);
			particle.visible = true;
			
			//set particle motion
			setParticleMotion(particle, angle, distance, lifespan, angleRange, distanceRange, lifespanRange);
	
			//add gravity
			particle.acceleration.y = gravity;
			
			//set particle rotation
			if(minRotation != maxRotation) { particle.angularVelocity = minRotation + FlxG.random() * (maxRotation - minRotation); }
			else {particle.angularVelocity = minRotation; }
			if (particle.angularVelocity != 0) { particle.angle = FlxG.random() * 360 - 180; }
			
			//set particle drag
			particle.drag.x = particleDrag.x;
			particle.drag.y = particleDrag.y;
			
			//emit particle
			particle.onEmit();
		}
		
	}

}