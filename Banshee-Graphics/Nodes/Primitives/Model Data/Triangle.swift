import MetalKit

class Triangle: BaseMeshData {
    var meshDataType: MeshDataTypes = MeshDataTypes.TRIANGLE
    var primitiveType: MTLPrimitiveType = MTLPrimitiveType.triangle
    var indexType: MTLIndexType = MTLIndexType.uint32

    var vertices: [Vertex]! = [
        Vertex(position: float3(0,1,0), color: float3(1,0,0), normal: float3(0,0,0), textureCoordinate: float2(0.5, 0)),
        Vertex(position: float3(-1,-1,0), color: float3(0,1,0), normal: float3(0,0,0), textureCoordinate: float2(0, 1)),
        Vertex(position: float3(1,-1,0), color: float3(0,0,1), normal: float3(0,0,0), textureCoordinate: float2(1, 1))
    ]
    
    var indices: [UInt32]! = [
        0,1,2
    ]
}

