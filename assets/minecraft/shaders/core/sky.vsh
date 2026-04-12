#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <terf:utils.glsl>

in vec3 Position;

out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out mat4 ProjInv;

out vec4 fragColor;

void main() {
    if (is_shader_sky(FogEnvironmentalStart)) {
        vec4 pos = ProjMat * vec4(Position, 1.0);
        pos.y = -pos.z;
        gl_Position = pos;
    }
    else
    {
        gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

        sphericalVertexDistance = fog_spherical_distance(Position);
        cylindricalVertexDistance = fog_cylindrical_distance(Position);
    }

    fragColor = apply_fog(ColorModulator, sphericalVertexDistance, cylindricalVertexDistance, 0.0, FogSkyEnd, FogSkyEnd, FogSkyEnd, FogColor);
    ProjInv = inverse(ProjMat * ModelViewMat);
}
