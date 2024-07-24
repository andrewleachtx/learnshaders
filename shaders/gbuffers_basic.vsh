#version 460
#include "common.glsl"

// https://github.com/sp614x/optifine/blob/master/OptiFineDoc/doc/shaders.txt

#define MV modelViewMatrix
#define MVit modelViewMatrixInverse
#define P projectionMatrix

// MV, MVit, P to convert to screen space
uniform mat4 modelViewMatrix;       
uniform mat4 modelViewMatrixInverse;
uniform mat4 projectionMatrix;

// Not attribute anymore bc geometry shader. Simply in/out
in vec3 vaPosition; // stores (x y z) for a given vertex - vertex attribute == va

// Texture map coordinates use a texture atlas
in vec2 vaUV0;

out vec2 texCoords;

void main() {
    // We move from object -> world -> view -> clip space, where v_c = projection * modelview * vaPosition
    // OpenGL handles perspective division and clipping once in clip space.
    gl_Position = P * MV * vec4(vaPosition, 1.0);

    texCoords = vaUV0;

    /*
        static void resize_callback(GLFWwindow *window, int width, int height) {
            glViewport(0, 0, width, height);
        }

        This exemplifies how glViewport is used to convert gl_Position (after OpenGL does perspective & clips) from
        clip -> ndc -> screen space
    */
}