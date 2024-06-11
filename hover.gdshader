shader_type canvas_item;

global uniform float bpm : hint_range(0.0, 300.0) = 50;
uniform float amplitude : hint_range(0.0, 50.0) = 4.0;
uniform float flash_mix : hint_range(0.0, 1.0, 0.1) = 0.0;

void vertex() {
    float time = TIME * (PI / 60.0 * bpm);
    float offset = sin(time) * amplitude;
    VERTEX.y += offset;
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(1).rgb, flash_mix);
	COLOR = color;
}