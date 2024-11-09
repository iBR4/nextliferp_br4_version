resource: Shader panel v1.1
author: Ren712
contact: knoblauch700@o2.pl

This is a UI panel for managing additional shader graphics effects.

Known issues: DoF and Water refract might not work properly when Anti Aliasing is on.

version 1.1
-reverted contrast shader back to "HDR Contrast"
-new palette shader effect
-replaced most of the enb palettes (thx to GhostRider)
-Appropriate texture for car paint shader.

version 1.08
-fixed: 'No Antialiasing' issue.

version 1.07
-rewritten contrast shader (to work properly with palette).
version 1.06	
-rewritten the palette effect.
-significantly changed Dof and water refract effects.
-changed the palette format from .bmp to .png
-added 10 new palettes.
-Resigned from get/setElementData usage in favor of client/server events.
-Minor effect tweaks.
version 1.03
-fixed a major crash when client is starting the resource.

Options:
-shader palette (supports ENB palettes) [you can add more than two]
-shader carpaint fix, reflect and reflect lite.
-shader depth of field and water refract 2 (enabled if supported by your GFX)
-shader bloom, contrast and shader water by Ccw.
-Handles external resources (detail and radial_blur)
[You need get and start the resources manually]
http://nightly.mtasa.com/files/shaders/shader_radial_blur.zip
http://nightly.mtasa.com/files/shaders/shader_detail.zip

Hit F3 to open the panel.

You can now SAVE your options if you're logged in.
Edit default_settings.xml to define DEFAULT options when player joins.
Also lock or, disable certain settings. Make the window appear after join.
Rewritten and reconfigured some of the effects and the menu itself.

Effects [depth of field and water refract 2] might not work on your 
video card. You have to also disable antialiasing in game menu.
Also update your MTA to the newest nightly.

-- Reading depth buffer supported by:
-- NVidia - from GeForce 6 (2004)
-- Radeon - from 9500 (2002)
-- Intel - from G45 (2008)

If there is anything wrong (anything to fix)or some ideas - feel free to leave a comment. 
