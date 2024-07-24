#version 460 compatibility

out vec2 texCoords;
out vec4 vaColor;

void main() {
	gl_Position = ftransform();
	texCoords = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	vaColor = gl_Color;
}