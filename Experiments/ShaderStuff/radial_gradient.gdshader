shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float dist = distance(vec2(0.5), UV) * 2.0;
	float alpha = 1.0 - pow(dist, 1);

	COLOR.a = smoothstep(0.0, 1.0, alpha);
}
