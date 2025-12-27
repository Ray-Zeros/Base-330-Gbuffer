#version 330 compatibility

#include "settings.glsl"

uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;
uniform float viewHeight;
uniform float viewWidth;

in vec2 texcoord;
in vec4 glcolor;

/* RENDERTARGETS: 0 */
layout(location = 0) out vec4 color;

void main() {

	if (SUPER_RES_SCALE > 1.001) {
		float scale = 1.0 / float(SUPER_RES_SCALE);
		vec2 renderLimit = vec2(viewWidth, viewHeight) * scale;
		if (gl_FragCoord.x > renderLimit.x || gl_FragCoord.y > renderLimit.y) {
            discard; 
        }
	}

	color = texture(gtexture, texcoord) * glcolor;
	if (color.a < alphaTestRef) {
		discard;
	}
}