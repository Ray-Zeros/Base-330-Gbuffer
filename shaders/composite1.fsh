#version 330 compatibility

#include "settings.glsl"

uniform sampler2D colortex0;

in vec2 texcoord;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {

    vec4 finalColor;

    if (SUPER_RES_SCALE > 1.001) {
        vec2 LRTexCoord = texcoord / float(SUPER_RES_SCALE);
        
        finalColor = texture2D(colortex0, LRTexCoord);
    } else {
        finalColor = texture2D(colortex0, texcoord);
    }

    color = finalColor;

}
