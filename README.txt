If you want a bunch of particles to emit in a 360° angle you'll notice 
that the FlxEmitter spawns them in a square. 
The result is that it looks like as if all particles are 
imprisoned in an extending square. 
This sucks if you want to use emitters for explosions. 
Also all emitted particles will disappear at the same time, 
as you set the same lifespan for all of them. :o

Therefore I wrote this extended FlxEmitter that emits particles in a circle.
It also provides a new function "setMotion" to control particle behavior even more. 
Note: This was inspired by the way Chevy Ray Johnston implemented his particle emitter in Flashpunk.