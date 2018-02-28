import MetalKit

class Triangle: BaseMeshData {
    
    var meshType: MeshTypes! = MeshTypes.TRIANGLE
    
    var vertices: [Vertex]! = [
        Vertex(position: float3(0,1,0), color: float4(1,0,0,1), normal: float3(0,0,0), textureCoordinate: float2(0.5, 0)),
        Vertex(position: float3(-1,-1,0), color: float4(0,1,0,1), normal: float3(0,0,0), textureCoordinate: float2(0, 1)),
        Vertex(position: float3(1,-1,0), color: float4(0,0,1,1), normal: float3(0,0,0), textureCoordinate: float2(1, 1))
    ]
    
    var indices: [UInt32]! = [
        0,1,2
    ]
}

