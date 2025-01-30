struct UNIFORM_BUFFER
{
    float4x4 model;
    float4x4 view;
    float4x4 proj;
}

struct VS_OUTPUT
{
    float4 Pos : SV_Position;
    float4 Colour : Color;
}

struct VS_INPUT
{
    float2 Position: Position;
    float4 Colour: Color;
}

[[vk::binding(0)]]
UNIFORM_BUFFER ubo: register(b0);

[shader("vertex")]
VS_OUTPUT vertexMain(VS_INPUT input){
    VS_OUTPUT output;
    output.Pos = mul(ubo.proj, mul(ubo.view, mul(ubo.model, float4(input.Position, 0.0, 1.0))));
    output.Colour = input.Colour;
    return output;
}

[shader("pixel")]
float4 fragmentMain(VS_OUTPUT input){
    return input.Colour;
}