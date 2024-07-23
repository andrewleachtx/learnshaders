#version 460

// https://github.com/sp614x/optifine/blob/master/OptiFineDoc/doc/shaders.txt

// Not attribute anymore bc geometry shader. Simply in/out
in vec3 vaPosition; // stores (x y z) for a given vertex

void main() {
    // We move from object -> world -> view -> clip space, where v_c = projection * modelview * vaPosition
    // OpenGL handles perspective division and clipping once in clip space.
    gl_Position = vec4(vaPosition, 1.0);

    /*
        static void resize_callback(GLFWwindow *window, int width, int height) {
            glViewport(0, 0, width, height);
        }

        This exemplifies how glViewport is used to convert gl_Position (after OpenGL does perspective & clips) from
        clip -> ndc -> screen space
    */
}