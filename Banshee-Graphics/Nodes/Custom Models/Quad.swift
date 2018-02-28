import MetalKit

class Quad: GameObject {
    override func buildVertices(){
        
        vertices = [
            Vertex(position: float3( 1,  1, 0), color: float4(1, 0 ,0, 1), textureCoordinate: float2(1,0)), //Top Right
            Vertex(position: float3(-1,  1, 0), color: float4(0, 1, 0 ,1), textureCoordinate: float2(0,0)), //Top Left
            Vertex(position: float3(-1, -1, 0), color: float4(0, 0, 1, 1), textureCoordinate: float2(0,1)), //Bottom Left
            
            Vertex(position: float3( 1,  1, 0), color: float4(1, 0 ,0, 1), textureCoordinate: float2(1,0)), //Top Left
            Vertex(position: float3(-1, -1, 0), color: float4(0, 0, 1, 1), textureCoordinate: float2(0,1)), //Bottom Left
            Vertex(position: float3( 1, -1, 0), color: float4(1, 0, 1, 1), textureCoordinate: float2(1,1))  //Bottom Right
        ]
    }
}

