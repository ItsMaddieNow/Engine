
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

[shader("vertex")]
VS_OUTPUT vertexMain(VS_INPUT input){
    VS_OUTPUT output;
    output.Pos = float4(input.Position, 0.0, 1.0);
    output.Colour = input.Colour;
    return output;
}

[shader("pixel")]
float4 fragmentMain(VS_OUTPUT input){
    return input.Colour;
}