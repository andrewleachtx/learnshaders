#version 460

// Inbuilt gtexture
uniform sampler2D gtexture;

/* DRAWBUFFERS:0 */
// outColor0 should go to the first color attachment draw buffer
layout (location = 0) out vec4 outColor0;

in vec2 texCoords;
in vec3 foliageColor;

void main() {
    // Our current color is grayscaled
    vec4 outputColorTexture = texture(gtexture, texCoords);
    vec3 outputColor = outputColorTexture.rgb * foliageColor;
    float transparency = outputColorTexture.a;

    // Account for transparent values
    if (transparency < 0.1) {
        discard;
    }

    outColor0 = vec4(outputColor, transparency);
}