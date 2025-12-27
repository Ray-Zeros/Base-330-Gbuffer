#version 330 compatibility

#include "settings.glsl"
#include "functions.glsl"

out vec2 lmcoord;
out vec4 glcolor;

const float lrScale = 1.0 / float(SUPER_RES_SCALE);
const vec2 lrOffsetFactor = vec2(lrScale - 1.0);

void main() {
	gl_Position = ftransform();

	ApplyLRScale(gl_Position, lrScale, lrOffsetFactor);

	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
}