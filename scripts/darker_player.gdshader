shader_type canvas_item;

uniform bool active = false;

// Palette (normalized 0–1)
const vec3 palette[5] = vec3[](
    vec3(27.0/255.0,  20.0/255.0,  30.0/255.0),  // #1b141e
    vec3(116.0/255.0, 100.0/255.0, 127.0/255.0), // #74647f
    vec3(177.0/255.0, 142.0/255.0, 142.0/255.0), // #b18e8e
    vec3(227.0/255.0, 196.0/255.0, 176.0/255.0), // #e3c4b0
    vec3(253.0/255.0, 245.0/255.0, 241.0/255.0)  // #fdf5f1
);

vec3 nearest_palette_color(vec3 color) {
    float best_dist = 99999.0;
    vec3 best_color = color;

    for (int i = 0; i < 5; i++) {
        float d = distance(color, palette[i]);
        if (d < best_dist) {
            best_dist = d;
            best_color = palette[i];
        }
    }
    return best_color;
}

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    // Start from original color
    vec3 base_color = tex.rgb;

    if (active) {
        // Darken
        vec3 darkened = base_color * 0.6;
        // Snap to nearest palette color
        base_color = nearest_palette_color(darkened);
    }

    COLOR = vec4(base_color, tex.a);
}