#version 460 compatibility

// Atlases or maps based on UV data
uniform sampler2D lightmap;
uniform sampler2D depthtex0;

/* DRAWBUFFERS:0 */
// outColor0 should go to the first color attachment draw buffer
layout (location = 0) out vec4 outColor0;

uniform float viewHeight;
uniform float viewWidth;
uniform vec3 fogColor;

in vec4 blockColor;
in vec2 lightMapCoords;
in vec3 viewSpacePos;

void main() {
    // Get the color of light
    vec3 lightColor = pow(texture(lightmap, lightMapCoords).rgb, vec3(2.2));

    // Our current color is grayscaled
    vec4 outputColorTexture = blockColor;
    vec3 outputColor = outputColorTexture.rgb * lightColor;
    float transparency = outputColorTexture.a;

    // Account for transparent values
    if (transparency < 0.1) {
        discard;
    }

    // We can access the z buffer (depthtex0) with frag coords x and y
    vec2 texCoord = gl_FragCoord.xy / vec2(viewWidth, viewHeight);
    float depth = texture(depthtex0, texCoord).x; // stored in index 0

    // If the distant horizons block has a depth
    if (depth != 1.0) {
        discard;
    }

    // Distance (in camera space) of fragment to the player camera (0, 0, 0)
    float distFromCam = distance(vec3(0.0), viewSpacePos);

    float maxFogDist = 4000;
    float minFogDist = 2500;

    float fogBlendCoef = clamp((distFromCam - minFogDist) / (maxFogDist - minFogDist), 0, 1);

    outputColor = mix(outputColor, pow(fogColor, vec3(2.2)), fogBlendCoef);

    outColor0 = pow(vec4(outputColor, transparency), vec4(1 / 2.2));
}