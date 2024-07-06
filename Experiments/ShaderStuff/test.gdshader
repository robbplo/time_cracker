shader_type canvas_item;

instance uniform vec4 my_color : hint_color; // Edit as a color.

void fragment() {
    COLOR = mycolor.rgb;
}
