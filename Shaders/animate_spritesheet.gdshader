//
// AnimatedSprite behaviour implemented as a spatial shader.
// Enables use of spritesheets in a material.
//

shader_type spatial;
render_mode blend_add, unshaded;

uniform sampler2D spritesheet : source_color, filter_nearest, repeat_enable;

uniform int framerate = 16;
uniform int hframes = 1;
uniform int vframes = 1;
varying float instance_frame;

void vertex() {
	instance_frame = INSTANCE_CUSTOM.z;
}

void fragment() {
	int total_frames = hframes * vframes;
	float frametime = 1.0 / float(framerate);
	int frame = int(mod((TIME + instance_frame) / frametime, float(total_frames)));

    vec2 sheet_resolution = vec2(ivec2(hframes, vframes));
	vec2 frame_coords = vec2(ivec2(frame % hframes, frame / vframes));
	vec2 frame_uv = UV / sheet_resolution + frame_coords / sheet_resolution;;
	vec4 frame_texture = texture(spritesheet, frame_uv);

	ALBEDO = frame_texture.rgb;
	ALPHA = frame_texture.a;
}
