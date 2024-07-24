#version 460
#include "common.glsl"
#include "defines.glsl"

// Uniforms
uniform vec3 chunkOffset; // all chunks have a unique offset within model space
uniform mat4 modelViewMatrix;       
uniform mat4 modelViewMatrixInverse;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition; // camera in world space
uniform mat4 gbufferModelViewInverse; // "closer" to MVit

// Attributes
in vec3 vaPosition;
in vec2 vaUV0;
in vec4 vaColor; // (r, g, b, a) of a vertex

// Varying
out vec2 texCoords;
out vec3 foliageColor;

void main() {
    texCoords = vaUV0;
    foliageColor = vaColor.rgb;

    vec3 vaPosChunk = vaPosition + chunkOffset;
    gl_Position = P * MV * vec4(vaPosChunk, 1.0);
}