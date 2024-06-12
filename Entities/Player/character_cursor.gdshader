shader_type canvas_item;

global uniform float bpm;
uniform float flash_mix : hint_range(0.0, 1.0, 0.1) = 0.0;
uniform vec3 flash_rgb : source_color = vec3(1.0);

void vertex() {
   	float beat = 60.0 / bpm;
    float time = mod(TIME, beat) * -1.0 + beat;
    float offset = time * 3.0;
	float x = max(1, offset);
	VERTEX = VERTEX * vec2(x);
	
}

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	color.rgb = mix(color.rgb, vec3(1).rgb, flash_mix);
	COLOR = color;
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
