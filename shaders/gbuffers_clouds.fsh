#version 460 compatibility

uniform sampler2D gtexture;

in vec2 texCoords;
in vec4 vaColor;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 color;

void main() {
	color = texture(gtexture, texCoords) * vaColor;
        
	if (color.a < 0.1) {
		discard;
	}
}