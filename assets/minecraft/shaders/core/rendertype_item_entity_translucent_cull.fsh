#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>
#moj_import <terf:surfaces.glsl>
uniform sampler2D Sampler0;

flat in int shaderID; // Our shader ID, it either 0, or a number from 1111 to 4444 (each digit represents {alpha - 250}, so it is a number from 1 to 4)
// you have 256 uniqe shader variants in total (4 ^ 4 = 256), I hope this is more than enough.
in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
flat in ivec2 UVTexelOrigin;
flat in vec2 atlasSize;
in vec2 texCoord1;
in vec4 control;

out vec4 fragColor;

void main()
{
    if (shaderID >= 1111) // It should be {... > 0}, but it really doesnt matter
    {
        // Changing this may cause unexpected behaviour, so I left most of it as it is
        // !!!WARNING *old* code BELOW!!! Jona was not happy about my wit
        //vec2 atlasSize = textureSize(Sampler0, 0);
        vec2 currentPixel = texCoord0 * atlasSize;
        vec2 texCoord = (currentPixel - vec2(UVTexelOrigin)) * 0.0625; // divide by 16
        vec2 NoiseProvider = texCoord0 * 1000.0; // Base noise scale?

        if (shaderID == 4444)
        {
            // Test shader. (Magma/sun surface)

            float time = GameTime * 1000.0;
            float intensity = 0.0;

            int i;
            for (i = 0; i < 20; i++) {
                intensity += max(perlinNoise(NoiseProvider*i + time + hash(vec2(i)).x),0.0)/2.0;
            }

            fragColor = vec4(intensity, intensity/2.0, intensity/4.0, 1.0);
        }
        else if (shaderID == 4443)
        {
            // Warp core shader (white spiral)
            vec2 point = texCoord;
            if (control.b/256.0 > 2.0) {
                point += vec2(0.0,1.0);
                if (texCoord.y > .5) {
                    point += vec2(0.0,-2.0);
                }
            }

            float dist = distance(point, vec2(0.5));
            float angle = angleBetween(point, vec2(0.5));
            float time = GameTime*1000.0;

            fragColor = vec4(sin(dist*10.-time+angle));
        }
        else if (shaderID == 4442)
        {
            // Stfr Shutdown Fail Restabilization shader. (flames from the centre)
        
            float time = GameTime + control.b;
            float fade = control.g-distance(texCoord, vec2(0.5))*2.0;
            float angle = angleBetween(vec2(0.5),texCoord)+GameTime;

            float angleIntensity = perlinPolar(angle,(fade/10.)+time*500.0,16.0);
            float intensity = (max(angleIntensity,0.0)+0.1) * perlinPolar(angle,fade*4.0+time*20000.0,16.0);

            fragColor = vec4(blackbody(fade*angleIntensity*30000.0), max(intensity,0.)*fade*20.0);

            if (control.r < 0.1) {
                angleIntensity = perlinNoise(vec2((angle-GameTime*1000.0)*5.0, control.b*420.0))+0.5;
                time = 0.01+control.r + mod(GameTime*24000.0,1.0)/256.0;
                if (angleIntensity > time*9.0) {
                    float dist = distance(texCoord, vec2(0.5))*2.0;
                    fragColor = max(min(fragColor, 1.0), 0.0) + vec4(1.0, 1.0, 1.0, 1.0-dist);
                }
            }
        }
        else if (shaderID == 4441)
        {
            // Seismic Charge Flash shader. (ender fragon death lights, but white)

            if (control.b == 0.0) discard;
        
            float time = control.b + mod(GameTime*24000.0,1.0)/256.0;
            float dist = distance(texCoord, vec2(0.5))*2.0;

            float angle = angleBetween(vec2(0.5),texCoord);
            float angleIntensity = perlinNoise(vec2(angle*5.0))+0.5;

            if (angleIntensity < time*4.0 || dist > 1.0) discard;
            fragColor = vec4(1.0);
        }
        else if (shaderID == 4434)
        {
            // Seismic Charge shader. (Cyan/blue expanding energy disk)

            if (control.b == 0.0) discard;
        
            float time = control.b + mod(GameTime*24000.0,1.0)/256.0;
            float dist = distance(texCoord, vec2(0.5))*2.0;
            if (dist > 1.0) discard; 
            float radius = dist+(1.0-time);

            if (radius < 1.0) {
                float intensity = (radius-0.9)*10.0*(1+perlinNoise(NoiseProvider*100.0)/10.0);
                vec3 color = vec3(pow(intensity+0.05,20.0)-1.0, intensity, 1.0);
                fragColor = vec4(color, intensity - max(time-0.9, 0.0)*10.0);
            } else {
                // flash
                float angle = floor(angleBetween(vec2(0.5),texCoord)*45.0)/45.0;
                float iTime = pow(time+1.0, 0.5)-1.0;
                fragColor = vec4(vec3(1.0), ((0.2-iTime)*15.0 + hash(vec2(angle)).x - iTime*20.0) * max(1.0-dist, 0.0));
            }
        }
        else
        {
            // Debug. (renders blinking placeholder texture)
            float time = GameTime * 1000.0;
            fragColor = vec4(vertexColor.rgb, abs(sin(time)));
        }
        // Remove all empty pixels
        if (fragColor.a <= 0.0) discard;
        return;
    }
    else
    {
        // vanilla code
        vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
        if (color.a < 0.1) {
            discard;
        }
        fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
    }
}
