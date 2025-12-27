void ApplyLRScale(inout vec4 pos, float scale, vec2 offset) {
    if (SUPER_RES_SCALE > 1.001) {
        pos.xy = (pos.xy * scale) + offset * pos.w;
    }
}