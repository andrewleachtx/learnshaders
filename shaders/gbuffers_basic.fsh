#version 460

/* DRAWBUFFERS:0 */
// outColor0 should go to the first color attachment draw buffer
layout (location = 0) out vec4 outColor0;

void main() {
    outColor0 = vec4(1.0);
}