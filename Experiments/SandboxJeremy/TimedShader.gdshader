shader_type spatial;

global uniform float progress_1bar;

void vertex() {
	//POSITION = vec4(VERTEX, 1.0);
	//VERTEX.x = (VERTEX.x * progress_1bar);
}

void fragment() {
	ALBEDO = vec3(0.0);

}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
