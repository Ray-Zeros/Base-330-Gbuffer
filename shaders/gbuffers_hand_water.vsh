#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

out vec2 lmcoord;
out vec2 texcoord;
out vec4 glcolor;
out vec3 worldNormal;
out vec4 currentClipPos;
out vec4 previousClipPos;

void main() {
	gl_Position = ftransform();
	texcoord = (gl_TextureMatrix[0] * gl_MultiTexCoord0).xy;
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;
	
	vec3 viewNormal = normalize(gl_NormalMatrix * gl_Normal);
	worldNormal = (gbufferModelViewInverse * vec4(viewNormal,0)).xyz;

	currentClipPos = gl_Position;
	previousClipPos = gl_Position;
}