#version 330 compatibility

uniform sampler2D lightmap;
uniform sampler2D gtexture;

uniform float alphaTestRef = 0.1;

in vec2 lmcoord;
in vec2 texcoord;
in vec4 glcolor;
in vec3 worldNormal;

/* RENDERTARGETS: 0,4,5 */
layout(location = 0) out vec4 color;
layout(location = 1) out vec4 brdf;
layout(location = 2) out vec4 normal;

void main() {
	color = texture(gtexture, texcoord) * glcolor;
	color *= texture(lightmap, lmcoord);
	if (color.a < alphaTestRef) {
		discard;
	}
	brdf = color;

	vec3 N = normalize(worldNormal) * 0.5 + 0.5;
	normal = vec4(N, 1.0);
}