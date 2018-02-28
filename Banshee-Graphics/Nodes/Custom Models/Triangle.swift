import MetalKit

class Triangle: GameObject {
    override func buildVertices() {
        vertices = [
            Vertex(position: float3(0,1,0), color: float4(1,0,0,1), textureCoordinate: float2(0.5, 0)),
            Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1), textureCoordinate: float2(0, 1)),
            Vertex(position: float3(1,-1,0), color: float4(0,0,1,1), textureCoordinate: float2(1, 1))
        ]
    }
    
    override func buildIndices() {
        indices = [
            0,1,2
        ]
    }
}
