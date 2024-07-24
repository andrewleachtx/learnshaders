#version 460
#include "common.glsl"

// Inbuilt gtexture
uniform sampler2D gtexture;

/* DRAWBUFFERS:0 */
// outColor0 should go to the first color attachment draw buffer
layout (location = 0) out vec4 outColor0;

in vec2 texCoords;

void main() {
    outColor0 = texture(gtexture, texCoords);
}