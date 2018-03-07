import MetalKit

class MeshData {
    var vertexBuffer: MTLBuffer!
    var indexBuffer: MTLBuffer!
    var vertexDescriptor: MTLVertexDescriptor!
    var primitiveType: MTLPrimitiveType!
    var indexCount: Int!
    var vertexCount: Int!
    var indexType: MTLIndexType!
    var boundingBox: MDLAxisAlignedBoundingBox!
    var boundingSphere: BoundingSphere!
}
