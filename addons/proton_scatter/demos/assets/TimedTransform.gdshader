shader_type spatial;
global uniform float progress_1bar;
global uniform float progress_2bar;
global uniform float progress_4bar;

void vertex() {
	VERTEX.x = VERTEX.x*(progress_1bar/4.0+0.75);
	VERTEX.y = VERTEX.y*(progress_2bar/4.0+0.75);
	VERTEX.z = VERTEX.z*(progress_4bar/4.0+0.75);
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
