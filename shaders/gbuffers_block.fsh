#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

uniform float viewHeight;
uniform float viewWidth;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 worldNormal;
in vec4 currentClipPos;
in vec4 previousClipPos;

/* RENDERTARGETS: 0,4,5,6 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 brdf;
layout(location = 2) out vec4 normal;
layout(location = 3) out vec4 motion;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}
	brdf = color;

	vec3 N = normalize(worldNormal) * 0.5 + 0.5;
	normal = vec4(N, 1.0);

	vec3 currentNDC = currentClipPos.xyz / currentClipPos.w;
    vec3 previousNDC = previousClipPos.xyz / previousClipPos.w;
	vec2 deltaNDC = currentNDC.xy - previousNDC.xy;
	vec2 pixelVelocity = deltaNDC * vec2(viewWidth, viewHeight);

	motion = vec4(pixelVelocity, 0.0, 1.0);
}