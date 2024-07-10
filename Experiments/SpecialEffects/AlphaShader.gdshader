shader_type canvas_item;

uniform float speed : hint_range(0.0, 20.0, 0.1);
uniform float brightness : hint_range(-1.0, 1.0, 0.01);

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable,filter_nearest_mipmap;

uniform vec2 r_displace = vec2(3.0, 0.0);
uniform float r_time = 1;
uniform vec2 g_displace = vec2(3.0, 0.0);
uniform float g_time = 1;
uniform vec2 b_displace = vec2(3.0, 0.0);
uniform float b_time = 1;



void vertex() {

}

void fragment() {
	float alpha_mod = COLOR.a;
	vec3 c = textureLod(screen_texture, SCREEN_UV, 0.0).rgb;

	float r = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*(sin(TIME*r_time*speed)*r_displace*alpha_mod)), 0.0).r;
	float g = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*(cos(TIME*g_time*speed)*g_displace*alpha_mod)), 0.0).g;
	float b = texture(screen_texture, SCREEN_UV + vec2(SCREEN_PIXEL_SIZE*(sin(TIME*b_time*speed)*b_displace*alpha_mod)), 0.0).b;
	r += brightness;
	g += brightness;
	b += brightness;

    COLOR = vec4(g, r, r, alpha_mod);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
