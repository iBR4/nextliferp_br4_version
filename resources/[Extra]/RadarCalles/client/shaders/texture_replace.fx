texture gTexture;

technique TextureReplace {
	pass Pass0 {
		Texture[0] = gTexture;
                ColorOp[0] = SelectArg1;
	}
}