import MetalKit

class Quad: BaseMeshData {
    var meshDataType: MeshDataTypes = MeshDataTypes.QUAD
    var primitiveType: MTLPrimitiveType = MTLPrimitiveType.triangle
    var indexType: MTLIndexType = MTLIndexType.uint32
    var mins: float3 = float3(-1, -1, -0.05)
    var maxs: float3 = float3(1, 1, 0.05)
    
    var vertices: [Vertex]! = [
        Vertex(position: float3( 1,  1, 0), color: float3(1, 0 ,0), normal: float3(0,0,0), textureCoordinate: float2(1,0)), //Top Right
        Vertex(position: float3(-1,  1, 0), color: float3(0, 1, 0), normal: float3(0,0,0), textureCoordinate: float2(0,0)), //Top Left
        Vertex(position: float3(-1, -1, 0), color: float3(0, 0, 1), normal: float3(0,0,0), textureCoordinate: float2(0,1)), //Bottom Left

        Vertex(position: float3( 1,  1, 0), color: float3(1, 0 ,0), normal: float3(0,0,0), textureCoordinate: float2(1,0)), //Top Left
        Vertex(position: float3(-1, -1, 0), color: float3(0, 0, 1), normal: float3(0,0,0), textureCoordinate: float2(0,1)), //Bottom Left
        Vertex(position: float3( 1, -1, 0), color: float3(1, 0, 1), normal: float3(0,0,0), textureCoordinate: float2(1,1))  //Bottom Right
    ]
    
    var indices: [UInt32]! = []
}

