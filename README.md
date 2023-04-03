# FPS from Ohio (OhioFPS)

My first 3D game

made for the Archbishop Macdonald High School game jam 2023

So, we made this 3D FPS that gets progressively harder. The graphics are very basic and the physics are very janky, but what if I told you it was a purposeful stylistic choice. Personally, I've always been a fan of graphics and physics that are purposefully made bad for the funny. On the last day, the name finally popped into my head. Ohio, the meme, and FPS because it's our game. 

Anyway, the controls are wasd, space for jump, and mouse for shoot. You can play it here or grab the Windows (untested, might just blow up in your face) or Linux downloads for controller support (xbox controller only, playstation might work but idk). Not able to provide Mac version cause I don't have a Mac, but you can always download the source and build it yourself. When using a controller, it is left stick for move around, right stick for look around, A for jump, and one of the triggers (varies across platforms) for shoot. The app captures your mouse, so to move out of the window, press the escape key. 

Also, the movement would occasionally drift and I haven't found a fix for that yet, but if you hold w, a, s, and d all at once, the drift will stop. I also found that if you are using a controller, there will be no drift. Also avoid jumping into the walls cause you might just get stuck somewhere. 



Side note, to gain health from killing the enemies, you'll have to be close to it before it dies, which carries obvious risk. 



All code, graphics, audio, and otherwise assets are made in-house by our team (except for the game engine and fonts of course). 



## Import

I've used Godot for this, so clone or download a zip of this repo and import it open project.godot in godot 4.0

## Music
I've used Bitwig Studio for the soundtrack (and the shooting sound). To open it you'll need:
- [Bitwig Studio](https://bitwig.com) (open in demo mode [free])
- Bitwig essentials samples
- [Vital](https://vital.audio) synth
- [SurgeXT](https://surge-synth-team.org/surge/) synth
- [Dexed](https://asb2m10.github.io/dexed/) synth
- [Monique](https://surge-synth-team.org/monique/) synth
- [helm](https://tytel.org/helm/)

If you are really curious, import the [Bitwig project](https://github.com/william-v4/OhioFPS/tree/main/music/musicfromohio) and have a look



The laser gun sound is on the track named `pew pew`
