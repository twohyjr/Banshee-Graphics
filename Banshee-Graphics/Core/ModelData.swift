import MetalKit

struct ModelData{
    var name: String = String.Empty
    var positions: [float3] = []
    var indices: [UInt32] = []
    var textureCoords: [float2] = []
    var normals: [float3] = []
    var vertices: [Vertex] = []

    var colorNum: Float = 0.0
    mutating func addPosition(_ position: float3){
        positions.append(position)
        vertices.append(Vertex(position: position, color: float4(1), normal: float3(0), textureCoordinate: float2(0)))
        colorNum += 0.005
    }
    
    mutating func addTextureCoord(_ textureCoord: float2){
        textureCoords.append(textureCoord)
    }
    
    mutating func addNormal(_ normal: float3){
        normals.append(normal)
    }
    
    mutating func updateVertex(_ vertexData: int3){
        let vertexIndex = Int(vertexData.x) - 1
        indices.append(UInt32(vertexIndex))
        
        let position: float3 = positions[Int(vertexData.x) - 1]
        vertices[vertexIndex].position = position
        
        if(textureCoords.count > 0){
            let textureCoord: float2 = textureCoords[Int(vertexData.y) - 1]
            vertices[vertexIndex].textureCoordinate = float2(textureCoord.x, 1 - textureCoord.y) //blender starts from bottom left
        }
        
        if(normals.count > 0){
            let normal: float3 = normals[Int(vertexData.z) - 1]
            vertices[vertexIndex].normal = normal
        }
    }
}
