#version 460

#define MV modelViewMatrix
#define MVit modelViewMatrixInverse
#define P projectionMatrix
#define gMVit gbufferModelViewInverse // this is "closer" to MVit

uniform vec3 chunkOffset; // all chunks have a unique offset within model space
uniform mat4 modelViewMatrix;       
uniform mat4 modelViewMatrixInverse;
uniform mat4 projectionMatrix;
uniform vec3 cameraPosition; // camera in world space
uniform mat4 gbufferModelViewInverse; // "closer" to MVit

in vec3 vaPosition;
in vec2 vaUV0;

out vec2 texCoords;

void main() {
    texCoords = vaUV0;

    // We can get the world space position of a vertex this way
    vec4 camSpaceVertexPos = MV * vec4(vaPosition + chunkOffset, 1.0);
    vec4 playerSpaceVertexPos = gMVit * camSpaceVertexPos;
    vec3 worldSpaceVertexPos = cameraPosition + playerSpaceVertexPos.xyz;

    float distanceFromCam = distance(worldSpaceVertexPos, cameraPosition);

    gl_Position = P * MV * vec4((vaPosition + chunkOffset) + .5 * distanceFromCam, 1.0);
}