#version 330

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>
#moj_import <minecraft:globals.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 control;

out vec4 fragColor;

const vec2 ATLAS_SIZE = vec2(2048, 4096);

// Required Functions

// Check function
bool isShaderID(float ID, vec2 texCoordI, out vec2 texCoord) {
    if (texCoordI.y > ID*16.0) {
        texCoord = (texCoordI - 1 - vec2(0.0, ID*16.0)) / 16.0; // All textures on the atlas were extended by 1 pixel in 1.21.11 for some reason
        return true;
    }
    return false;
}

// Angle between 2 points
float angleBetween(vec2 a, vec2 b) {
    vec2 d = b - a;
    return atan(d.y, d.x);
}

// Blackbody function
vec3 blackbody(float T)
{
    // Clamp temperature range (valid approx 1000K–40000K)
    T = clamp(T, 1000.0, 40000.0) / 100.0;

    float r, g, b;

    // --- Red ---
    if (T <= 66.0) {
        r = 1.0;
    } else {
        float t = T - 60.0;
        r = 1.292936186062745 * pow(t, -0.1332047592);
    }

    // --- Green ---
    if (T <= 66.0) {
        g = 0.3900815787690196 * log(T) - 0.6318414437886275;
    } else {
        float t = T - 60.0;
        g = 1.129890860895294 * pow(t, -0.0755148492);
    }

    // --- Blue ---
    if (T >= 66.0) {
        b = 1.0;
    } else if (T <= 19.0) {
        b = 0.0;
    } else {
        b = 0.5432067891101961 * log(T - 10.0) - 1.19625408914;
    }

    return clamp(vec3(r, g, b), 0.0, 1.0);
}

// Hash function
vec2 hash(vec2 p) {
    p = vec2(
        dot(p, vec2(127.1, 311.7)),
        dot(p, vec2(269.5, 183.3))
    );
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

// Random value function
float random(float x) {
    return fract(sin(x * 127.1) * 43758.5453123);
}

// Fade curve (Perlin's improved smoothing)
vec2 fade(vec2 t) {
    return t * t * t * (t * (t * 6.0 - 15.0) + 10.0);
}

// 2D Perlin noise
float perlinNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);

    vec2 u = fade(f);

    float a = dot(hash(i + vec2(0.0, 0.0)), f - vec2(0.0, 0.0));
    float b = dot(hash(i + vec2(1.0, 0.0)), f - vec2(1.0, 0.0));
    float c = dot(hash(i + vec2(0.0, 1.0)), f - vec2(0.0, 1.0));
    float d = dot(hash(i + vec2(1.0, 1.0)), f - vec2(1.0, 1.0));

    return mix(
        mix(a, b, u.x),
        mix(c, d, u.x),
        u.y
    );
}

// Polar Perlin Noise
float perlinPolar(float a, float r, float angularScale) {
    const float TWO_PI = 6.28318530718;

    // Normalize angle to [0,1] and scale
    float u = fract(a / TWO_PI) * angularScale;

    vec2 p = vec2(u, r);
    vec2 i = floor(p);
    vec2 f = fract(p);

    // Wrap angular grid (tile in x direction)
    float wrappedX = mod(i.x, angularScale);

    vec2 i00 = vec2(wrappedX, i.y);
    vec2 i10 = vec2(mod(wrappedX + 1.0, angularScale), i.y);
    vec2 i01 = vec2(wrappedX, i.y + 1.0);
    vec2 i11 = vec2(mod(wrappedX + 1.0, angularScale), i.y + 1.0);

    // Gradient vectors
    vec2 g00 = normalize(hash(i00));
    vec2 g10 = normalize(hash(i10));
    vec2 g01 = normalize(hash(i01));
    vec2 g11 = normalize(hash(i11));

    // Distance vectors
    vec2 d00 = f - vec2(0.0, 0.0);
    vec2 d10 = f - vec2(1.0, 0.0);
    vec2 d01 = f - vec2(0.0, 1.0);
    vec2 d11 = f - vec2(1.0, 1.0);

    // Dot products
    float n00 = dot(g00, d00);
    float n10 = dot(g10, d10);
    float n01 = dot(g01, d01);
    float n11 = dot(g11, d11);

    vec2 w = fade(f);

    float nx0 = mix(n00, n10, w.x);
    float nx1 = mix(n01, n11, w.x);
    float nxy = mix(nx0, nx1, w.y);

    return nxy;
}

void main() {
    // Calculate the texture coords in atlas pixel space
    vec2 texCoordI = texCoord0 * ATLAS_SIZE;

    // If not within the shaderspace, dont even bother checking
    if (texCoordI.x < 17.0) {
        vec2 texCoord;

        // Check the texture coordinates to know which shader to display
            if (isShaderID(127.0, texCoordI, texCoord)) {
            // Test shader

            float time = GameTime * 1000.0;
            float intensity = 0.0;

            int i;
            for (i = 0; i < 20; i++) {
                intensity += max(perlinNoise(texCoord*i + time + hash(vec2(i)).x),0.0)/2.0;
            }

            fragColor = vec4(intensity, intensity/2.0, intensity/4.0, 1.0);
            
        } else if (isShaderID(3.0, texCoordI, texCoord)) {
            // Warp core shader
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

        } else if (isShaderID(2.0, texCoordI, texCoord)) {
            // Stfr Shutdown Fail Restabilization shader
        
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

        } else if (isShaderID(1.0, texCoordI, texCoord)) {
            // Seismic Charge Flash shader

            if (control.b == 0.0) discard;
        
            float time = control.b + mod(GameTime*24000.0,1.0)/256.0;
            float dist = distance(texCoord, vec2(0.5))*2.0;

            float angle = angleBetween(vec2(0.5),texCoord);
            float angleIntensity = perlinNoise(vec2(angle*5.0))+0.5;

            if (angleIntensity < time*4.0 || dist > 1.0) discard;
            fragColor = vec4(1.0);
            
        } else if (isShaderID(0.0, texCoordI, texCoord)) {
            // Seismic Charge shader

            if (control.b == 0.0) discard;
        
            float time = control.b + mod(GameTime*24000.0,1.0)/256.0;
            float dist = distance(texCoord, vec2(0.5))*2.0;
            float radius = dist+(1.0-time);

            if (radius < 1.0) {
                float intensity = (radius-0.9)*10.0*(1+perlinNoise(texCoordI*10.0)/10.0);
                vec3 color = vec3(pow(intensity+0.05,20.0)-1.0, intensity, 1.0);
                fragColor = vec4(color, intensity - max(time-0.9, 0.0)*10.0);
            } else {
                // flash
                float angle = floor(angleBetween(vec2(0.5),texCoord)*45.0)/45.0;
                float iTime = pow(time+1.0, 0.5)-1.0;
                fragColor = vec4(vec3(1.0), ((0.2-iTime)*15.0 + hash(vec2(angle)).x - iTime*20.0) * max(1.0-dist, 0.0));
            }
        }

        // Let me be clear
        if (fragColor.a <= 0.0) discard;
        return;
    }

    // vanilla code
    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    fragColor = apply_fog(color, sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
