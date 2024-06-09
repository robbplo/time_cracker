shader_type canvas_item;

uniform float amplitude : hint_range(0.0, 50.0) = 4.0;
uniform float bpm : hint_range(0.0, 300.0) = 50;
void vertex() {
    float time = TIME * (PI / 60.0 * bpm);
    float offset = sin(time) * amplitude;
    VERTEX.y += offset;
}