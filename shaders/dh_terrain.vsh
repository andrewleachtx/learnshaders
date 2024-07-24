#version 460 compatibility
#include "common.glsl"
#include "defines.glsl"

// Uniforms

// Attributes

// Varying
out vec4 blockColor;
out vec2 lightMapCoords; // flags this vertex as something not to use interpolation for in fragment shader

void main() {
    blockColor = gl_Color;
    lightMapCoords = (gl_TextureMatrix[1] * gl_MultiTexCoord2).xy;

    gl_Position = ftransform();
}