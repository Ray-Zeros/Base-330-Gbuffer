#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

out vec2 lmcoord;
out vec4 glcolor;
out vec3 worldNormal;

void main() {
	gl_Position = ftransform();
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;

	vec3 viewNormal = normalize(gl_NormalMatrix * gl_Normal);
	worldNormal = (gbufferModelViewInverse * vec4(viewNormal,0)).xyz;
}