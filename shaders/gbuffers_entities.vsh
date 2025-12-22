#version 330 compatibility

uniform mat4 gbufferModelViewInverse;

uniform vec3 cameraPosition;
uniform vec3 previousCameraPosition;
uniform mat4 gbufferPreviousModelView;
uniform mat4 gbufferPreviousProjection;

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

	// Entities use local space
	vec4 viewPos = gl_ModelViewMatrix * gl_Vertex;
	vec3 worldPos = (gbufferModelViewInverse * viewPos).xyz + cameraPosition;
	vec3 prevWorldPos = worldPos;
	vec3 prevRelativePos = prevWorldPos - previousCameraPosition;
	previousClipPos = gbufferPreviousProjection * gbufferPreviousModelView * vec4(prevRelativePos, 1.0);

	// vec3 relativePos = gl_Vertex.xyz + (cameraPosition - previousCameraPosition);
	// previousClipPos = gbufferPreviousProjection * gbufferPreviousModelView * vec4(relativePos, 1.0);
}