// Sky pass: fullscreen triangle generated from the vertex index, no vertex
// buffers, no uniforms. The fragment shader reconstructs the view ray.

#version 450

layout(location = 0) out vec2 v_ndc;

void main()
{
    // (-1,-1), (3,-1), (-1,3): one triangle covering the whole screen
    vec2 pos = vec2( float( ( gl_VertexIndex << 1 ) & 2 ),
                     float( gl_VertexIndex & 2 ) ) * 2.0 - 1.0;
    v_ndc = pos;
    gl_Position = vec4( pos, 0.0, 1.0 );
}
