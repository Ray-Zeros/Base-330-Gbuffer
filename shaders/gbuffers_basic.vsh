#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferPreviousProjection;

out vec2 lmcoord;
out vec4 glcolor;
out vec3 worldNormal;
out vec4 currentClipPos;
out vec4 previousClipPos;

void main() {
	gl_Position = ftransform();
	lmcoord = (gl_TextureMatrix[1] * gl_MultiTexCoord1).xy;
	glcolor = gl_Color;

	vec3 viewNormal = normalize(gl_NormalMatrix * gl_Normal);
	worldNormal = (gbufferModelViewInverse * vec4(viewNormal,0)).xyz;

	currentClipPos = gl_Position;
	vec3 relativePos = gl_Vertex.xyz + (cameraPosition - previousCameraPosition);
	previousClipPos = gbufferPreviousProjection * gbufferPreviousModelView * vec4(relativePos, 1.0);
}