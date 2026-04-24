#version 330

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:projection.glsl>
#moj_import <minecraft:globals.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV1;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

flat out int shaderID; // Shader that will be used in fragment shader;
out float sphericalVertexDistance;
out float cylindricalVertexDistance;
out vec4 vertexColor;
out vec2 texCoord0;
flat out ivec2 UVTexelOrigin; // Corner of a current triangle in texel coords
flat out vec2 atlasSize;
out vec2 texCoord1;
out vec2 texCoord2;
out vec4 control; // Animation parametrs for some shaders

int calculateShaderID(in ivec2 cornerPos)
{
    int ID = 0;
    for (int i = 0; i < 4; i++)
    {
        ID *= 10;
        ID += int(round(texelFetch(Sampler0, cornerPos + ivec2(i, 0), 0).w * 255.0)) - 250; // Read 4 pixels from bottom left corner
    }
    return ID;
}

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    sphericalVertexDistance = fog_spherical_distance(Position);
    cylindricalVertexDistance = fog_cylindrical_distance(Position);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color) * texelFetch(Sampler2, UV2 >> 4, 0); //Changed UV2 / 16 to UV2 >> 4
    texCoord0 = UV0;
    
    shaderID = 0; // Default value, in case the previous data is not deleted correctly

    // Here goes modified code
    // Check 2 oposite corners for special texels (alpha = 254)
    
    int alpha = int(round((texture(Sampler0, UV0) * vertexColor * ColorModulator).w * 255.0));
    if (alpha == 254)
    {
        atlasSize = vec2(textureSize(Sampler0, 0));
        ivec2 UVtoTexel = ivec2(UV0 * atlasSize);

        ivec2 cornerPos = UVtoTexel;
        int vertexID = gl_VertexID % 4; // Check which corner was that

        if (vertexID == 0)
        {
            cornerPos += ivec2(0, 16); // Move to texture origin
            shaderID = calculateShaderID(cornerPos);
            UVTexelOrigin = UVtoTexel;
        }
        else
        {
            cornerPos += ivec2(-16, 0); // Move to texture origin
            shaderID = calculateShaderID(cornerPos);
            UVTexelOrigin = UVtoTexel - ivec2(16);
        }
    }
    // Back to vanilla stuff

    texCoord1 = UV1;
    texCoord2 = UV2;

    // Jona passes down the colour, so he can control animations.
    control = Color;
}
