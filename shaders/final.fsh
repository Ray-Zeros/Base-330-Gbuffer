#version 330 compatibility

#include "settings.glsl"
#include "buffers.glsl"

uniform sampler2D colortex0;
uniform sampler2D colortex4; 
uniform sampler2D colortex5; 
uniform sampler2D colortex6;

in vec2 texcoord;

layout(location = 0) out vec3 color;

void main() {
    color = texture(colortex0, texcoord).rgb;

    #ifdef DEBUG_GBUFFER_VIEW
        float scale = 0.15;
        float gap = 0.01;
        
        // Albedo
        if (texcoord.x < scale && texcoord.y > (1.0 - scale)) {
            vec2 smallUV;
            smallUV.x = texcoord.x / scale;
            smallUV.y = (texcoord.y - (1.0 - scale)) / scale;
            
            color = texture(colortex4, smallUV).rgb;
        }
        
        // Normal
        else if (texcoord.x < scale && texcoord.y > (1.0 - 2.0 * scale)) {
            vec2 smallUV;
            smallUV.x = texcoord.x / scale;
            smallUV.y = (texcoord.y - (1.0 - 2.0 * scale)) / scale;
            
            vec3 norm = texture(colortex5, smallUV).rgb;
            color = norm;
        }
        
        // Motion
        else if (texcoord.x < scale && texcoord.y > (1.0 - 3.0 * scale)) {
            vec2 smallUV;
            smallUV.x = texcoord.x / scale;
            smallUV.y = (texcoord.y - (1.0 - 3.0 * scale)) / scale;
            
            vec3 motion = texture(colortex6, smallUV).rgb;

            color = motion; 
        }
        
        // gap lines
        if (texcoord.x > scale - 0.002 || 
           (texcoord.y < 1.0 - scale + 0.002 && texcoord.y > 1.0 - scale - 0.002) ||
           (texcoord.y < 1.0 - 2.0*scale + 0.002 && texcoord.y > 1.0 - 2.0*scale - 0.002)) {
               if (texcoord.x < scale && texcoord.y > 1.0 - 3.0 * scale) {
                   color = vec3(1.0);
               }
        }
    #endif
}