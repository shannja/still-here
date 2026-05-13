shader_type canvas_item;
render_mode unshaded;

uniform sampler2D false_texture : filter_nearest;
uniform sampler2D true_texture : filter_nearest;
uniform sampler2D noise_texture : filter_nearest;
uniform float progress : hint_range(0.0, 1.0) = 0.0;

void fragment() {
    vec4 false_img = texture(false_texture, UV);
    vec4 true_img = texture(true_texture, UV);
    float noise = texture(noise_texture, UV).r;
    
    float threshold = step(noise, progress);
    COLOR = mix(false_img, true_img, threshold);
}