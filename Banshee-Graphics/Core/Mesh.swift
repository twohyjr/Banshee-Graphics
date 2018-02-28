import MetalKit

class Mesh {
    var vertexBuffer: MTLBuffer
    var vertexDescriptor: MTLVertexDescriptor
    var primitiveType: MTLPrimitiveType
    var indexBuffer: MTLBuffer
    var indexCount: Int
    var indexType: MTLIndexType
    
    init?()
    {
        let allocator = MTKMeshBufferAllocator(device: Engine.device)
        
        let mdlMesh: MDLMesh = MDLMesh(planeWithExtent: vector_float3(10, 10, 10),
                                       segments: vector_uint2(100, 100),
                                       geometryType: .triangles,
                                       allocator: allocator)
        
        do {
            let mtkMesh = try MTKMesh(mesh: mdlMesh, device: Engine.device)
            let mtkVertexBuffer = mtkMesh.vertexBuffers[0]
            let submesh = mtkMesh.submeshes[0]
            let mtkIndexBuffer = submesh.indexBuffer
            
            vertexBuffer = mtkVertexBuffer.buffer
            vertexBuffer.label = "Mesh Vertices"
            
            vertexDescriptor = MTKMetalVertexDescriptorFromModelIO(mdlMesh.vertexDescriptor)!
            primitiveType = submesh.primitiveType
            indexBuffer = mtkIndexBuffer.buffer
            indexBuffer.label = "Mesh Indices"
            
            indexCount = submesh.indexCount
            indexType = submesh.indexType
        } catch _ {
            return nil // Unable to create MTK mesh from MDL mesh
        }
    }
}
