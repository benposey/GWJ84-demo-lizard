shader_type canvas_item;

uniform float SPEED = 1;

void vertex() {
	UV.y += TIME * SPEED;
}