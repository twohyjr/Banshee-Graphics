import MetalKit

protocol BaseMeshData {
    var meshDataType: MeshDataTypes { get }
    var vertices: [Vertex]! { get set }
    var indices: [UInt32]! { get set }
    var primitiveType: MTLPrimitiveType { get }
    var indexType: MTLIndexType { get }
}

extension BaseMeshData{
    
    var vertexDescriptor: MTLVertexDescriptor{
        return BaseVertexDescriptorLibrary.vertexDescriptor(.BASIC)
    }
    
    var vertexBuffer:MTLBuffer{
        return Engine.device.makeBuffer(bytes: vertices, length: Vertex.size(vertices.count), options: [])!
    }
    
    var indexBuffer:MTLBuffer{
        return Engine.device.makeBuffer(bytes: indices, length: MemoryLayout<UInt32>.size * indices.count, options: [])!
    }
    
    var indexCount: Int{
        return indices.count
    }
    
    var vertexCount: Int{
        return vertices.count
    }
    
}
