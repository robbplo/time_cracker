shader_type canvas_item;

global uniform float progress_1bar;
global uniform float progress_2bar;
global uniform float progress_4bar;
global uniform float progress_8bar;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (UV.x < 0.25)
		COLOR.rgb = vec3(progress_1bar);
	if (UV.x > 0.25 && UV.x < 0.5)
		COLOR.rgb = vec3(progress_2bar);
	if (UV.x > 0.5 && UV.x < 0.75)
		COLOR.rgb = vec3(progress_4bar);
	if (UV.x > 0.75 && UV.x < 1.0)
		COLOR.rgb = vec3(progress_8bar);

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
