#include <metal_stdlib>
using namespace metal;

struct VertexIn{
    float3 position [[ attribute(0) ]];
    float4 color [[ attribute(1) ]];
    float2 textureCoordinate [[ attribute(2) ]];
};

struct VertexOut{
    float4 position [[ position ]];
    float4 color;
    float2 textureCoordinate;
};

struct ModelConstants{
    float4x4 modelMatrix;
};

struct SceneConstants{
    float4x4 projectionMatrix;
    float4x4 viewMatrix;
};

//Declare shared functions up here
float4 getViewPosition(float3 vertexPosition, ModelConstants modelConstants, SceneConstants sceneConstants);

//-----------------BASIC SHADERS-----------------------
vertex VertexOut basic_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                     constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                     constant ModelConstants &modelConstants [[ buffer(2) ]]){
    VertexOut vOut;
    
    vOut.position = getViewPosition(vIn.position, modelConstants, sceneConstants);
    vOut.color = vIn.color;
    vOut.textureCoordinate = vIn.textureCoordinate;
    
    return vOut;
}

fragment half4 basic_fragment_shader(const VertexOut vIn [[ stage_in ]]){
    float4 color = vIn.color;
    return half4(color.r, color.g, color.b, color.a);
}

//-----------------TEXTURED SHADERS-----------------------
vertex VertexOut textured_vertex_shader(const VertexIn vIn [[ stage_in ]],
                                        constant SceneConstants &sceneConstants [[ buffer(1) ]],
                                        constant ModelConstants &modelConstants [[ buffer(2) ]]){
    VertexOut vOut;
    
    vOut.position = getViewPosition(vIn.position, modelConstants, sceneConstants);
    vOut.color = vIn.color;
    vOut.textureCoordinate = vIn.textureCoordinate;
    
    return vOut;
}

fragment half4 textured_fragment_shader(const VertexOut vIn [[ stage_in ]],
                                        sampler sampler2d [[ sampler(0) ]],
                                        texture2d<float> texture [[ texture(0) ]]){
    float4 color = texture.sample(sampler2d, vIn.textureCoordinate);
    return half4(color.r, color.g, color.b, color.a);
}


//------------------SHARED FUNCTIONS---------------------------
float4 getViewPosition(float3 vertexPosition, ModelConstants modelConstants, SceneConstants sceneConstants){
    return sceneConstants.projectionMatrix * sceneConstants.viewMatrix * modelConstants.modelMatrix * float4(vertexPosition, 1.0);
}
