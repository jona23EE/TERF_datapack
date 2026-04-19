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

// Sine hash function
vec2 sinHash(vec2 p) {
    p = vec2(
        dot(p, vec2(127.1, 311.7)),
        dot(p, vec2(269.5, 183.3))
    );
    return -1.0 + 2.0 * fract(sin(p) * 43758.5453123);
}

// Hash function
vec2 hash(vec2 p) {
    vec3 p3 = fract(vec3(p.xyx) * vec3(0.1031, 0.1030, 0.0973));
    p3 += dot(p3, p3.yzx + 33.33);
    return fract((p3.xx + p3.yz) * p3.zy) * 2.0 - 1.0;
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
