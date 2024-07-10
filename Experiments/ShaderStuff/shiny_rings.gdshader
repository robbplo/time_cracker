shader_type canvas_item;

// Gradient function with 4 input vectors
// https://iquilezles.org/articles/palettes/
vec3 palette_calc( float t, vec3 a, vec3 b, vec3 c, vec3 d) {
    return a + b*cos(TAU*(c*t+d) );
}

vec3 palette( float t ) {
    vec3 a = vec3(0.5, 0.5, 0.5);
    vec3 b = vec3(0.5, 0.5, 0.5);
    vec3 c = vec3(1.0, 1.0, 1.0);
    vec3 d = vec3(0.263,0.416,0.557);

    return palette_calc(t,a,b,c,d);
}


void fragment() {
    // Multiplying the UV vector by 2 and subtracting 1 transforms it to clip space, where
    // The coordinates range from -1 to 1. This places the origin point at 0,0.
	vec2 uv = UV * 2.0 - 1.0;
	// Copy the original uv coordinates so we can create a repeating pattern in uv
	vec2 uv0 = uv;
	vec3 finalColor = vec3(0.0);

	for (float i = 0.0; i < 4.0; i++) {
        // The function fract returns the decimal part of a float.
		// Multiplying uv will make it grow past the clip spaces values of -1 .. 1.
		// Taking only the fractional part results in a repeating pattern.
		uv = fract(uv * 1.5) - 0.5;

		// Distance is equal to the length of uv, since (0,0) is the center
		float d = length(uv);

		// Scale d exponentially by the negative length of uv0.
		// The further out from the center of the texture, the smaller the circles become.
		d *= exp(length(uv0));

		// Take a color from the palette based on the distance from the center of the texture.
		// Add a component of i to increase variance between iterations
		// And include the time component to increase overall variance
		vec3 col = palette(length(uv0) + i*.4 + TIME);

		// Take the sine of distance to create a circle with radius d
		// Scale the radius because sin of a number between -1 and 1 does not change much
		// Add the time component to create constant inward scaling
		d = sin(d*8.0 + TIME)/8.0;

		// Taking the absolute of d turns the circles into rings
		d = abs(d);

		// Currently, the rings will be black and the color will be applied outside the rings
		// Inverting d will apply the color the the rings themselves.
		// A normal inversion of 1.0/d will not work however, the result will be a pure white.
		// Inverting a number less than zero will always result in a number greater than 1.
		// A simple solution is to divide a smaller number by d.
		// Example: https://graphtoy.com/?f1(x,t)=1.0%20/%20x&v1=true&f2(x,t)=0.1%20/%20x&v2=true&f3(x,t)=0.01%20/%20x&v3=true&f4(x,t)=&v4=false&f5(x,t)=&v5=false&f6(x,t)=&v6=false&grid=1&coords=0,0,6.157897418768485
		d = 0.01 / d;

		// Taking an exponent of d will increase the contrast between produced colors.
		// When d is between 0 and 1, an exponent will
		// Example: https://graphtoy.com/?f1(x,t)=1.0%20/%20x&v1=true&f2(x,t)=0.1%20/%20x&v2=true&f3(x,t)=0.01%20/%20x&v3=true&f4(x,t)=&v4=false&f5(x,t)=&v5=false&f6(x,t)=&v6=false&grid=1&coords=0,0,6.157897418768485
		d = pow(d, 1.0);

		finalColor += col * d;
	}

	COLOR.rgb = finalColor;
}
